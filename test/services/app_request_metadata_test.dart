import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:yimaru_app/services/app_request_metadata.dart';

PackageInfo _info({String version = '1.5.2', String build = '83'}) =>
    PackageInfo(
      appName: 'Yimaru',
      packageName: 'com.example.yimaru',
      version: version,
      buildNumber: build,
    );

void main() {
  for (final platform in ['android', 'ios']) {
    test('$platform installed metadata is cached across concurrent requests',
        () async {
      var calls = 0;
      final metadata = AppRequestMetadata(
        platform: platform,
        loadPackageInfo: () async {
          calls++;
          return _info();
        },
      );
      final results = await Future.wait([metadata.headers, metadata.headers]);
      expect(results.first, {
        'X-App-Platform': platform,
        'X-App-Version': '1.5.2',
        'X-App-Build': '83',
      });
      expect(await metadata.headers, results.first);
      expect(calls, 1);
      expect(() => results.first['X-App-Version'] = 'other',
          throwsUnsupportedError);
    });
  }

  test('missing plugin never fails a request and is not repeatedly invoked',
      () async {
    var calls = 0;
    final metadata = AppRequestMetadata(
      platform: 'ios',
      loadPackageInfo: () async {
        calls++;
        throw StateError('plugin unavailable');
      },
    );
    expect(await metadata.headers, {'X-App-Platform': 'ios'});
    expect(await metadata.headers, {'X-App-Platform': 'ios'});
    expect(calls, 1);
  });

  test('stalled lookup is bounded but its late result restores metadata',
      () async {
    final pending = Completer<PackageInfo>();
    final metadata = AppRequestMetadata(
      platform: 'android',
      timeout: const Duration(milliseconds: 5),
      loadPackageInfo: () => pending.future,
    );
    expect(await metadata.headers, {'X-App-Platform': 'android'});
    pending.complete(_info());
    await Future<void>.delayed(Duration.zero);
    expect((await metadata.headers)['X-App-Version'], '1.5.2');
    expect((await metadata.headers)['X-App-Build'], '83');
  });

  test('failed lookup retries once after cooldown without blocking requests',
      () async {
    var now = DateTime.utc(2026, 10, 19);
    var calls = 0;
    final retry = Completer<PackageInfo>();
    final metadata = AppRequestMetadata(
      platform: 'ios',
      now: () => now,
      loadPackageInfo: () {
        calls++;
        if (calls == 1) throw StateError('temporary synchronous plugin error');
        return retry.future;
      },
    );
    expect(await metadata.headers, {'X-App-Platform': 'ios'});
    expect(await metadata.headers, {'X-App-Platform': 'ios'});
    expect(calls, 1);
    now = now.add(const Duration(seconds: 31));
    // Both the request triggering recovery and later concurrent requests must
    // finish while the plugin is still pending, not wait for its timeout.
    final responses = await Future.wait([metadata.headers, metadata.headers])
        .timeout(const Duration(milliseconds: 100));
    expect(responses.every((value) => value.length == 1), isTrue);
    expect(calls, 2);
    retry.complete(_info());
    await Future<void>.delayed(Duration.zero);
    expect((await metadata.headers)['X-App-Version'], '1.5.2');
    expect(calls, 2);
  });

  test('repeated failures are throttled and can later recover', () async {
    var now = DateTime.utc(2026, 10, 19);
    var calls = 0;
    final metadata = AppRequestMetadata(
      platform: 'android',
      now: () => now,
      loadPackageInfo: () async {
        calls++;
        if (calls < 3) throw StateError('temporary failure');
        return _info();
      },
    );
    await metadata.headers;
    for (var attempt = 0; attempt < 2; attempt++) {
      now = now.add(const Duration(seconds: 31));
      await Future.wait(List.generate(10, (_) => metadata.headers));
      await Future<void>.delayed(Duration.zero);
      expect(calls, attempt + 2);
    }
    expect((await metadata.headers)['X-App-Version'], '1.5.2');
  });

  test('a hung native call is never duplicated and later requests do not wait',
      () async {
    var now = DateTime.utc(2026, 10, 19);
    var calls = 0;
    final pending = Completer<PackageInfo>();
    final metadata = AppRequestMetadata(
      platform: 'android',
      now: () => now,
      timeout: const Duration(milliseconds: 5),
      loadPackageInfo: () {
        calls++;
        return pending.future;
      },
    );
    await metadata.headers;
    now = now.add(const Duration(hours: 1));
    await Future.wait(List.generate(10, (_) => metadata.headers))
        .timeout(const Duration(milliseconds: 100));
    expect(calls, 1);
    pending.complete(_info());
    await Future<void>.delayed(Duration.zero);
    expect((await metadata.headers)['X-App-Build'], '83');
  });

  test('partial package information can recover without losing valid values',
      () async {
    var now = DateTime.utc(2026, 10, 19);
    var calls = 0;
    final metadata = AppRequestMetadata(
      platform: 'ios',
      now: () => now,
      loadPackageInfo: () async => _info(build: ++calls == 1 ? '' : '83'),
    );
    expect((await metadata.headers)['X-App-Version'], '1.5.2');
    now = now.add(const Duration(seconds: 31));
    await metadata.headers;
    await Future<void>.delayed(Duration.zero);
    expect((await metadata.headers)['X-App-Build'], '83');
    expect(calls, 2);
  });

  test('invalid metadata is omitted without affecting the request', () async {
    final metadata = AppRequestMetadata(
      platform: 'macos',
      loadPackageInfo: () async => _info(version: 'bad\r\nheader', build: ''),
    );
    expect(await metadata.headers, isEmpty);
  });

  test('trailing control characters are never accepted into HTTP headers',
      () async {
    for (final value in ['1.5.2\n', '1.5.2\r', '1.5.2\r\n']) {
      final metadata = AppRequestMetadata(
        platform: 'ios',
        loadPackageInfo: () async => _info(version: value, build: value),
      );
      expect(await metadata.headers, {'X-App-Platform': 'ios'});
    }
  });
}
