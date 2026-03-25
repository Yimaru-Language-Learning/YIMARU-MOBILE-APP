import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/app/app.locator.dart';

import '../helpers/test_helpers.dart';

void main() {
  group('CourseCategoryViewModel Tests -', () {
    setUp(() => registerServices());
    tearDown(() => locator.reset());
  });
}
