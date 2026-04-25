// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/api_service.dart';
import '../services/audio_player_service.dart';
import '../services/authentication_service.dart';
import '../services/course_service.dart';
import '../services/dio_service.dart';
import '../services/google_auth_service.dart';
import '../services/image_downloader_service.dart';
import '../services/image_picker_service.dart';
import '../services/in_app_update_service.dart';
import '../services/notification_service.dart';
import '../services/permission_handler_service.dart';
import '../services/secure_storage_service.dart';
import '../services/smart_auth_service.dart';
import '../services/status_checker_service.dart';
import '../services/voice_recorder_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator(
    {String? environment, EnvironmentFilter? environmentFilter}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => SecureStorageService());
  locator.registerLazySingleton(() => DioService());
  locator.registerLazySingleton(() => StatusCheckerService());
  locator.registerLazySingleton(() => PermissionHandlerService());
  locator.registerLazySingleton(() => ImagePickerService());
  locator.registerLazySingleton(() => GoogleAuthService());
  locator.registerLazySingleton(() => ImageDownloaderService());
  locator.registerLazySingleton(() => NotificationService());
  locator.registerLazySingleton(() => SmartAuthService());
  locator.registerLazySingleton(() => CourseService());
  locator.registerLazySingleton(() => AudioPlayerService());
  locator.registerLazySingleton(() => VoiceRecorderService());
  locator.registerLazySingleton(() => InAppUpdateService());
}
