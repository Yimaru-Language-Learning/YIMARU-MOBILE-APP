import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/services/lesson_realtime_service.dart';

class _Socket implements WebSocket {
  final incoming = StreamController<dynamic>();
  final sent = <Map<String, dynamic>>[];
  bool closed = false;
  @override
  Duration? pingInterval;
  @override
  void add(dynamic data) =>
      sent.add(jsonDecode(data as String) as Map<String, dynamic>);
  @override
  StreamSubscription<dynamic> listen(void Function(dynamic)? onData,
          {Function? onError, void Function()? onDone, bool? cancelOnError}) =>
      incoming.stream.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
  @override
  Future<void> close([int? code, String? reason]) async {
    closed = true;
    unawaited(incoming.close());
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  for (final domain in ['lms', 'exam_prep']) {
    testWidgets('reopening $domain keeps a denied subscription retry alive',
        (tester) async {
      final socket = _Socket();
      var originalRefreshes = 0;
      var currentRefreshes = 0;
      final realtime = LessonRealtimeService(
          getToken: () async => 'access', connect: (_) async => socket);
      addTearDown(realtime.dispose);
      realtime.watch(domain, 45,
          refresh: () => originalRefreshes++,
          reset: () {},
          setForeground: (_) {});
      await tester.pump();
      socket.incoming.add(jsonEncode(
          {'type': 'subscription.denied', 'domain': domain, 'module_id': 45}));
      await tester.pump();
      expect(originalRefreshes, 1);

      await tester.pump(const Duration(seconds: 10));
      realtime.watch(domain, 45,
          refresh: () => currentRefreshes++,
          reset: () {},
          setForeground: (_) {});
      await tester.pump(const Duration(seconds: 19));
      expect(socket.sent.length, 1);
      await tester.pump(const Duration(seconds: 1));
      expect(socket.sent.length, 2);
      expect(socket.sent.last,
          {'type': 'subscribe', 'domain': domain, 'module_id': 45});

      socket.incoming.add(jsonEncode(
          {'type': 'subscribed', 'domain': domain, 'module_id': 45}));
      socket.incoming.add(jsonEncode(
          {'type': 'lessons.changed', 'domain': domain, 'module_id': 45}));
      await tester.pump();
      expect(originalRefreshes, 1);
      expect(currentRefreshes, 2);
      await tester.pump(const Duration(seconds: 60));
      expect(socket.sent.length, 2);
    });
  }

  testWidgets('switching modules cancels the denied subscription retry',
      (tester) async {
    final socket = _Socket();
    final realtime = LessonRealtimeService(
        getToken: () async => 'access', connect: (_) async => socket);
    addTearDown(realtime.dispose);
    realtime.watch('lms', 45,
        refresh: () {}, reset: () {}, setForeground: (_) {});
    await tester.pump();
    socket.incoming
        .add('{"type":"subscription.denied","domain":"lms","module_id":45}');
    await tester.pump();
    await tester.pump(const Duration(seconds: 10));
    realtime.watch('lms', 99,
        refresh: () {}, reset: () {}, setForeground: (_) {});
    expect(socket.sent.last,
        {'type': 'subscribe', 'domain': 'lms', 'module_id': 99});
    final sent = socket.sent.length;
    await tester.pump(const Duration(seconds: 60));
    expect(socket.sent.length, sent);
  });

  testWidgets('an acknowledgement cancels retry after reopening the module',
      (tester) async {
    final socket = _Socket();
    final realtime = LessonRealtimeService(
        getToken: () async => 'access', connect: (_) async => socket);
    addTearDown(realtime.dispose);
    void watch() => realtime.watch('lms', 45,
        refresh: () {}, reset: () {}, setForeground: (_) {});
    watch();
    await tester.pump();
    socket.incoming
        .add('{"type":"subscription.denied","domain":"lms","module_id":45}');
    await tester.pump();
    watch();
    socket.incoming.add('{"type":"subscribed","domain":"lms","module_id":45}');
    await tester.pump();
    await tester.pump(const Duration(seconds: 60));
    expect(socket.sent.length, 1);
  });

  testWidgets('credential rotation cancels retries from the old connection',
      (tester) async {
    final sockets = <_Socket>[];
    final realtime = LessonRealtimeService(
        getToken: () async => 'access',
        connect: (_) async {
          final socket = _Socket();
          sockets.add(socket);
          return socket;
        });
    addTearDown(realtime.dispose);
    realtime.watch('lms', 45,
        refresh: () {}, reset: () {}, setForeground: (_) {});
    await tester.pump();
    sockets.first.incoming
        .add('{"type":"subscription.denied","domain":"lms","module_id":45}');
    await tester.pump();
    await tester.pump(const Duration(seconds: 10));
    realtime.credentialsUpdated();
    await tester.pump();
    expect(sockets.length, 2);
    expect(sockets.first.closed, isTrue);
    await tester.pump(const Duration(seconds: 60));
    expect(sockets.first.sent.length, 1);
    expect(sockets.last.sent.length, 1);
  });

  testWidgets('logout cancels a denied subscription retry', (tester) async {
    final socket = _Socket();
    var connects = 0;
    final realtime = LessonRealtimeService(
        getToken: () async => 'access',
        connect: (_) async {
          connects++;
          return socket;
        });
    addTearDown(realtime.dispose);
    realtime.watch('lms', 45,
        refresh: () {}, reset: () {}, setForeground: (_) {});
    await tester.pump();
    socket.incoming
        .add('{"type":"subscription.denied","domain":"lms","module_id":45}');
    await tester.pump();
    realtime.reset();
    await tester.pump(const Duration(seconds: 60));
    expect(socket.closed, isTrue);
    expect(socket.sent.length, 1);
    expect(connects, 1);
  });

  testWidgets(
      'subscribes by domain, filters events and replaces the module scope',
      (tester) async {
    final socket = _Socket();
    final urls = <Uri>[];
    var lmsRefresh = 0;
    var examRefresh = 0;
    final realtime = LessonRealtimeService(
        getToken: () async => 'access',
        connect: (url) async {
          urls.add(Uri.parse(url));
          return socket;
        });
    addTearDown(realtime.dispose);
    realtime.watch('lms', 45,
        refresh: () => lmsRefresh++, reset: () {}, setForeground: (_) {});
    realtime.watch('exam_prep', 45,
        refresh: () => examRefresh++, reset: () {}, setForeground: (_) {});
    await tester.pump();
    expect(urls.single.path, '/api/v1/ws/connect');
    expect(urls.single.queryParameters['token'], 'access');
    expect(socket.sent.length, 2);
    socket.incoming.add('{"type":"subscribed","domain":"lms","module_id":45}');
    socket.incoming
        .add('{"type":"lessons.changed","domain":"exam_prep","module_id":45}');
    socket.incoming
        .add('{"type":"lessons.changed","domain":"lms","module_id":99}');
    socket.incoming.add('invalid');
    await tester.pump();
    expect(lmsRefresh, 1);
    expect(examRefresh, 1);
    realtime.watch('lms', 99,
        refresh: () => lmsRefresh++, reset: () {}, setForeground: (_) {});
    expect(socket.sent[socket.sent.length - 2],
        {'type': 'unsubscribe', 'domain': 'lms', 'module_id': 45});
    expect(socket.sent.last,
        {'type': 'subscribe', 'domain': 'lms', 'module_id': 99});
    socket.incoming
        .add('{"type":"lessons.changed","domain":"lms","module_id":45}');
    await tester.pump();
    expect(lmsRefresh, 1);
  });

  testWidgets(
      'resume reconnects; refreshed credentials reconnect; reset ends work',
      (tester) async {
    final sockets = <_Socket>[];
    final tokens = <String?>[];
    var token = 'first';
    var resets = 0;
    var refreshes = 0;
    final realtime = LessonRealtimeService(
        getToken: () async => token,
        connect: (url) async {
          tokens.add(Uri.parse(url).queryParameters['token']);
          final socket = _Socket();
          sockets.add(socket);
          return socket;
        });
    addTearDown(realtime.dispose);
    realtime.watch('lms', 1,
        refresh: () => refreshes++,
        reset: () => resets++,
        setForeground: (_) {});
    await tester.pump();
    realtime.didChangeAppLifecycleState(AppLifecycleState.paused);
    await tester.pump();
    expect(sockets.first.closed, isTrue);
    await tester.pump(const Duration(seconds: 60));
    expect(sockets.length, 1);
    realtime.didChangeAppLifecycleState(AppLifecycleState.resumed);
    await tester.pump();
    expect(sockets.length, 2);
    expect(sockets.last.sent.single['type'], 'subscribe');
    sockets.last.incoming
        .add('{"type":"subscribed","domain":"lms","module_id":1}');
    await tester.pump();
    expect(refreshes, 1);
    token = 'refreshed';
    realtime.credentialsUpdated();
    await tester.pump();
    expect(sockets.length, 3);
    expect(tokens, ['first', 'first', 'refreshed']);
    realtime.reset();
    await tester.pump(const Duration(seconds: 60));
    expect(resets, 1);
    expect(sockets.last.closed, isTrue);
    expect(sockets.length, 3);
  });

  testWidgets('a lost socket retries and restores subscriptions',
      (tester) async {
    final sockets = <_Socket>[];
    final realtime = LessonRealtimeService(
        getToken: () async => 'access',
        connect: (_) async {
          final socket = _Socket();
          sockets.add(socket);
          return socket;
        });
    addTearDown(realtime.dispose);
    realtime.watch('lms', 45,
        refresh: () {}, reset: () {}, setForeground: (_) {});
    await tester.pump();
    await sockets.first.incoming.close();
    await tester.pump();
    await tester.pump(const Duration(seconds: 2));
    expect(sockets.length, 2);
    expect(sockets.last.sent.single,
        {'type': 'subscribe', 'domain': 'lms', 'module_id': 45});
  });

  testWidgets('logout while connecting discards the late socket',
      (tester) async {
    final pending = Completer<WebSocket>();
    final socket = _Socket();
    final realtime = LessonRealtimeService(
        getToken: () async => 'access', connect: (_) => pending.future);
    addTearDown(realtime.dispose);
    realtime.watch('lms', 1,
        refresh: () {}, reset: () {}, setForeground: (_) {});
    await tester.pump();
    realtime.reset();
    pending.complete(socket);
    await tester.pump();
    expect(socket.closed, isTrue);
    expect(socket.sent, isEmpty);
  });
}
