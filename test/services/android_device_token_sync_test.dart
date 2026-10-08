import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/services/android_device_token_sync.dart';

class TokenUpload {
  TokenUpload(this.token, this.userId, this.cancellation);
  final String token;
  final int? userId;
  final CancelToken cancellation;
}

class TokenSyncHarness {
  String? token = 'token-1';
  int? userId = 1;
  Object? tokenError;
  Object? uploadError;
  Completer<String?>? tokenGate;
  Future<void> Function(TokenUpload)? onUpload;
  final uploads = <TokenUpload>[];
  int tokenReads = 0;
  int concurrentUploads = 0;
  int maxConcurrentUploads = 0;

  late final sync = AndroidDeviceTokenSync(
    getToken: () async {
      tokenReads++;
      if (tokenError != null) throw tokenError!;
      if (tokenGate != null) return tokenGate!.future;
      return token;
    },
    getAuthenticatedUserId: () async => userId,
    registerToken: (token, cancellation) async {
      final upload = TokenUpload(token, userId, cancellation);
      uploads.add(upload);
      concurrentUploads++;
      if (concurrentUploads > maxConcurrentUploads) {
        maxConcurrentUploads = concurrentUploads;
      }
      try {
        if (onUpload != null) await onUpload!(upload);
        if (uploadError != null) throw uploadError!;
      } finally {
        concurrentUploads--;
      }
    },
  );
}

DioException registrationFailure(int? status) => DioException(
      requestOptions: RequestOptions(path: '/devices/register'),
      type: status == null
          ? DioExceptionType.connectionError
          : DioExceptionType.badResponse,
      response: status == null
          ? null
          : Response(
              requestOptions: RequestOptions(path: '/devices/register'),
              statusCode: status,
            ),
    );

Future<void> flushSync(WidgetTester tester) async {
  await tester.pump();
  await tester.pump();
}

Future<void> captureSyncLogs(
    Future<void> Function(List<String> logs) check) async {
  final previous = debugPrint;
  final logs = <String>[];
  debugPrint = (String? message, {int? wrapWidth}) {
    if (message != null) logs.add(message);
  };
  try {
    await check(logs);
  } finally {
    debugPrint = previous;
  }
}

void main() {
  testWidgets('logs registration stages and skips without exposing the token',
      (tester) async {
    final h = TokenSyncHarness()..token = 'private-fcm-token';
    addTearDown(h.sync.dispose);
    await captureSyncLogs((logs) async {
      h.sync.receiveToken(h.token!);
      h.sync.setForeground(false);
      h.sync.beginSession(1);
      h.sync.setForeground(true);
      await flushSync(tester);
      h.sync.receiveToken(h.token!);
      expect(logs, containsAllInOrder([
        '[FCM Sync] Registration deferred: no authenticated session',
        '[FCM Sync] Registration deferred: app is backgrounded',
        '[FCM Sync] Token lookup started',
        '[FCM Sync] Token lookup completed: token available',
        '[FCM Sync] Backend registration started',
        '[FCM Sync] Backend registration succeeded',
        '[FCM Sync] Registration skipped: token already registered',
      ]));
      expect(logs.join('\n'), isNot(contains(h.token!)));
      expect(h.uploads, hasLength(1));
    });
  });

  testWidgets('logs safe failure details and bounded retry scheduling',
      (tester) async {
    const secret = 'private-token-email-and-credentials';
    final h = TokenSyncHarness()
      ..token = secret
      ..uploadError = DioException(
        requestOptions: RequestOptions(
          path: '/devices/register',
          data: {'device_token': secret},
          headers: {'Authorization': secret},
        ),
        type: DioExceptionType.badResponse,
        message: secret,
        response: Response(
          requestOptions: RequestOptions(path: '/devices/register'),
          statusCode: 503,
          data: secret,
        ),
      );
    addTearDown(h.sync.dispose);
    await captureSyncLogs((logs) async {
      h.sync.beginSession(1);
      await flushSync(tester);
      for (final seconds in [5, 30, 120]) {
        expect(logs, contains('[FCM Sync] Retry scheduled in ${seconds}s'));
        await tester.pump(Duration(seconds: seconds));
        await flushSync(tester);
      }
      expect(logs, contains(
          '[FCM Sync] Backend registration failed (DioException, HTTP 503).'));
      expect(logs, contains(
          '[FCM Sync] Retry limit reached: waiting for a recovery trigger'));
      expect(logs.join('\n'), isNot(contains(secret)));
      expect(logs, isNot(contains('[FCM Sync] Backend registration succeeded')));
      expect(h.uploads, hasLength(4));
    });
  });

  testWidgets('logs cancellation without claiming a late success',
      (tester) async {
    final h = TokenSyncHarness();
    final gate = Completer<void>();
    h.onUpload = (_) => gate.future;
    addTearDown(h.sync.dispose);
    await captureSyncLogs((logs) async {
      h.sync.beginSession(1);
      await flushSync(tester);
      h.sync.endSession();
      gate.complete();
      await flushSync(tester);
      expect(logs, contains(
          '[FCM Sync] Backend registration cancellation requested: session ended'));
      expect(logs, isNot(contains('[FCM Sync] Backend registration succeeded')));
      expect(h.uploads.single.cancellation.isCancelled, isTrue);
    });
  });

  testWidgets('refresh before login never uploads anonymously', (tester) async {
    final h = TokenSyncHarness()..token = 'refreshed-token';
    addTearDown(h.sync.dispose);
    h.sync.receiveToken('refreshed-token');
    await flushSync(tester);
    expect(h.uploads, isEmpty);
    expect(h.tokenReads, 0);
    h.sync.beginSession(1);
    await flushSync(tester);
    expect(h.uploads.single.token, 'refreshed-token');
    expect(h.uploads.single.userId, 1);
    expect(h.sync.hasPendingSync, isFalse);
  });

  testWidgets('restored session registers without a refresh event', (tester) async {
    final h = TokenSyncHarness();
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    expect(h.uploads.single.token, 'token-1');
    h.sync.beginSession(1);
    h.sync.receiveToken('token-1');
    h.sync.requestSync();
    h.sync.setForeground(false);
    h.sync.setForeground(true);
    await flushSync(tester);
    expect(h.uploads, hasLength(1));
  });

  testWidgets('nonblocking uploads are serialized and keep the newest token',
      (tester) async {
    final h = TokenSyncHarness();
    final first = Completer<void>();
    h.onUpload = (upload) async {
      if (upload.token == 'token-1') await first.future;
    };
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1); // Returns immediately despite the unfinished POST.
    await flushSync(tester);
    h.sync.receiveToken('token-2');
    h.sync.receiveToken('token-3');
    await flushSync(tester);
    expect(h.uploads, hasLength(1));
    first.complete();
    await flushSync(tester);
    expect(h.uploads.map((upload) => upload.token), ['token-1', 'token-3']);
    expect(h.maxConcurrentUploads, 1);
  });

  testWidgets('refresh wins over an older getToken result', (tester) async {
    final h = TokenSyncHarness()..tokenGate = Completer<String?>();
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    h.sync.receiveToken('new-token');
    h.tokenGate!.complete('old-token');
    await flushSync(tester);
    expect(h.uploads.single.token, 'new-token');
  });

  testWidgets('returning to the acknowledged token while uploading is not lost',
      (tester) async {
    final h = TokenSyncHarness();
    final gate = Completer<void>();
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    h.onUpload = (upload) async {
      if (upload.token == 'token-2') await gate.future;
    };
    h.sync.receiveToken('token-2');
    await flushSync(tester);
    h.sync.receiveToken('token-1');
    gate.complete();
    await flushSync(tester);
    expect(h.uploads.map((upload) => upload.token),
        ['token-1', 'token-2', 'token-1']);
    expect(h.sync.hasPendingSync, isFalse);
  });

  testWidgets('refresh survives a failed older token lookup', (tester) async {
    final h = TokenSyncHarness()..tokenGate = Completer<String?>();
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    h.sync.receiveToken('new-token');
    h.tokenGate!.completeError(Exception('Old lookup failed'));
    await flushSync(tester);
    expect(h.uploads.single.token, 'new-token');
    expect(h.tokenReads, 1);
  });

  testWidgets('stalled token lookup times out and permits recovery',
      (tester) async {
    final h = TokenSyncHarness()..tokenGate = Completer<String?>();
    final oldLookup = h.tokenGate!;
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    await tester.pump(const Duration(seconds: 15));
    h.tokenGate = null;
    h.token = 'recovered-token';
    await tester.pump(const Duration(seconds: 5));
    await flushSync(tester);
    expect(h.uploads.single.token, 'recovered-token');
    oldLookup.complete('stale-token');
    await flushSync(tester);
    expect(h.uploads, hasLength(1));
  });

  testWidgets('fresh authentication retries a rejected token', (tester) async {
    final h = TokenSyncHarness()..uploadError = registrationFailure(401);
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    h.uploadError = null;
    h.sync.credentialsUpdated();
    await flushSync(tester);
    expect(h.uploads, hasLength(2));
    expect(h.sync.hasPendingSync, isFalse);
  });

  testWidgets('credentials refreshed during an upload survive its old 401',
      (tester) async {
    final h = TokenSyncHarness();
    final gate = Completer<void>();
    h.onUpload = (_) async {
      if (h.uploads.length == 1) await gate.future;
    };
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    h.sync.credentialsUpdated();
    gate.completeError(registrationFailure(401));
    await flushSync(tester);
    expect(h.uploads, hasLength(2));
    expect(h.sync.hasPendingSync, isFalse);
  });

  for (final status in <int?>[null, 408, 429, 500, 503]) {
    testWidgets('transient HTTP $status retries at 5, 30, and 120 seconds',
        (tester) async {
      final h = TokenSyncHarness()..uploadError = registrationFailure(status);
      addTearDown(h.sync.dispose);
      h.sync.beginSession(1);
      await flushSync(tester);
      expect(h.uploads, hasLength(1));
      await tester.pump(const Duration(seconds: 4));
      expect(h.uploads, hasLength(1));
      await tester.pump(const Duration(seconds: 1));
      await flushSync(tester);
      expect(h.uploads, hasLength(2));
      await tester.pump(const Duration(seconds: 30));
      await flushSync(tester);
      expect(h.uploads, hasLength(3));
      await tester.pump(const Duration(seconds: 120));
      await flushSync(tester);
      expect(h.uploads, hasLength(4));
      await tester.pump(const Duration(hours: 1));
      expect(h.uploads, hasLength(4));
      h.uploadError = null;
      h.sync.requestSync();
      await flushSync(tester);
      expect(h.uploads, hasLength(5));
      expect(h.sync.hasPendingSync, isFalse);
    });
  }

  for (final status in [400, 401, 403, 404, 422]) {
    testWidgets('HTTP $status waits for a new token/session instead of looping',
        (tester) async {
      final h = TokenSyncHarness()..uploadError = registrationFailure(status);
      addTearDown(h.sync.dispose);
      h.sync.beginSession(1);
      await flushSync(tester);
      await tester.pump(const Duration(minutes: 10));
      h.sync.requestSync();
      await flushSync(tester);
      expect(h.uploads, hasLength(1));
      h.uploadError = null;
      h.sync.receiveToken('replacement-token');
      await flushSync(tester);
      expect(h.uploads.last.token, 'replacement-token');
      expect(h.uploads, hasLength(2));
    });
  }

  testWidgets('null tokens and Firebase errors recover without throwing',
      (tester) async {
    final h = TokenSyncHarness()..tokenError = Exception('Token unavailable');
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    expect(h.uploads, isEmpty);
    h.tokenError = null;
    h.token = null;
    await tester.pump(const Duration(seconds: 5));
    await flushSync(tester);
    expect(h.uploads, isEmpty);
    h.sync.receiveToken('event-token');
    await flushSync(tester);
    expect(h.uploads.single.token, 'event-token');
    await tester.pump(const Duration(minutes: 5));
    expect(h.uploads, hasLength(1));
  });

  testWidgets('missing or mismatched credentials prevent uploading',
      (tester) async {
    final h = TokenSyncHarness()..userId = null;
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    expect(h.uploads, isEmpty);
    h.userId = 2;
    h.sync.beginSession(1);
    await flushSync(tester);
    expect(h.uploads, isEmpty);
    h.sync.beginSession(2);
    await flushSync(tester);
    expect(h.uploads.single.userId, 2);
  });

  testWidgets('background pauses retries and resume checks the current token',
      (tester) async {
    final h = TokenSyncHarness()..uploadError = registrationFailure(null);
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    h.sync.setForeground(false);
    await tester.pump(const Duration(minutes: 5));
    expect(h.uploads, hasLength(1));
    h.uploadError = null;
    h.token = 'resumed-token';
    h.sync.setForeground(true);
    await flushSync(tester);
    expect(h.uploads.last.token, 'resumed-token');
  });

  testWidgets('logout cancels uploads and ignores their late completion',
      (tester) async {
    final h = TokenSyncHarness();
    final gate = Completer<void>();
    h.onUpload = (_) => gate.future;
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    h.sync.endSession();
    expect(h.uploads.single.cancellation.isCancelled, isTrue);
    h.userId = null;
    gate.complete();
    await flushSync(tester);
    h.sync.receiveToken('logged-out-token');
    h.sync.requestSync();
    await tester.pump(const Duration(minutes: 5));
    expect(h.uploads, hasLength(1));
  });

  testWidgets('account changes cannot inherit the previous acknowledgement',
      (tester) async {
    final h = TokenSyncHarness();
    final gate = Completer<void>();
    h.onUpload = (upload) async {
      if (upload.userId == 1) await gate.future;
    };
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    h.sync.endSession();
    h.userId = 2;
    h.sync.beginSession(2);
    expect(h.uploads.first.cancellation.isCancelled, isTrue);
    gate.complete();
    await flushSync(tester);
    expect(h.uploads.map((upload) => upload.userId), [1, 2]);
    expect(h.maxConcurrentUploads, 1);
  });

  testWidgets('logout during token lookup prevents a late upload',
      (tester) async {
    final h = TokenSyncHarness()..tokenGate = Completer<String?>();
    addTearDown(h.sync.dispose);
    h.sync.beginSession(1);
    await flushSync(tester);
    h.sync.endSession();
    h.tokenGate!.complete('late-token');
    await flushSync(tester);
    expect(h.uploads, isEmpty);
  });

  testWidgets('dispose cancels timers and ignores subsequent triggers',
      (tester) async {
    final h = TokenSyncHarness()..uploadError = registrationFailure(null);
    h.sync.beginSession(1);
    await flushSync(tester);
    h.sync.dispose();
    h.sync.receiveToken('ignored-token');
    h.sync.beginSession(2);
    h.sync.requestSync();
    await tester.pump(const Duration(hours: 1));
    expect(h.uploads, hasLength(1));
  });
}
