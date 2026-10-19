import 'package:flutter_test/flutter_test.dart';

import '../../tool/bump_version.dart';

void main() {
  const original = 'name: yimaru_app\nversion: 0.1.124+126\ndescription: App\n';

  test('patch bumps the version name and version code', () {
    expect(bumpVersion(original, 'patch'),
        'name: yimaru_app\nversion: 0.1.125+127\ndescription: App\n');
  });

  test('minor resets patch and increments the existing code', () {
    expect(bumpVersion(original, 'minor'),
        'name: yimaru_app\nversion: 0.2.0+127\ndescription: App\n');
  });

  test('major resets minor and patch and increments the existing code', () {
    expect(bumpVersion(original, 'major'),
        'name: yimaru_app\nversion: 1.0.0+127\ndescription: App\n');
  });

  test('repeated bumps keep increasing both version values', () {
    expect(bumpVersion(bumpVersion(original, 'patch'), 'patch'),
        contains('version: 0.1.126+128'));
  });

  test('preserves spacing, comments, CRLF, and unrelated fields', () {
    const input = 'name: app\r\nversion:\t1.2.3+9  # release\r\nother: x\r\n';
    expect(bumpVersion(input, 'patch'),
        'name: app\r\nversion:\t1.2.4+10  # release\r\nother: x\r\n');
  });

  test('works without a final newline', () {
    expect(bumpVersion('version: 1.2.3+9', 'patch'), 'version: 1.2.4+10');
  });

  test('allows the maximum supported next Android version code', () {
    expect(bumpVersion('version: 1.2.3+2099999999\n', 'patch'),
        'version: 1.2.4+2100000000\n');
  });

  for (final invalid in [
    'name: app\n',
    'version: 1.2.3\n',
    'version: 1.2.3-beta+9\n',
    'version: 1.2.3+0\n',
    'version: 1.2.3+2100000000\n',
    'version: 1.2.3+9\nversion: 1.2.4+10\n',
  ]) {
    test('rejects an unsupported or unsafe version: ${invalid.trim()}', () {
      expect(() => bumpVersion(invalid, 'patch'), throwsFormatException);
    });
  }

  test('rejects unknown bump types', () {
    expect(() => bumpVersion(original, 'build'), throwsFormatException);
  });
}
