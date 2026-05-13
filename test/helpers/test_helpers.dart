import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/secure_storage_service.dart';
import 'package:yimaru_app/services/dio_service.dart';
import 'package:yimaru_app/services/status_checker_service.dart';
import 'package:yimaru_app/services/permission_handler_service.dart';
import 'package:yimaru_app/services/image_picker_service.dart';
import 'package:yimaru_app/services/google_auth_service.dart';
import 'package:yimaru_app/services/image_downloader_service.dart';
import 'package:yimaru_app/services/notification_service.dart';
import 'package:yimaru_app/services/smart_auth_service.dart';
import 'package:yimaru_app/services/course_service.dart';
import 'package:yimaru_app/services/audio_player_service.dart';
import 'package:yimaru_app/services/voice_recorder_service.dart';
import 'package:yimaru_app/services/in_app_update_service.dart';
import 'package:yimaru_app/services/vimeo_service.dart';
import 'package:yimaru_app/services/url_launcher_service.dart';
import 'package:yimaru_app/services/phone_caller_service.dart';
import 'package:yimaru_app/services/learn_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<AuthenticationService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<ApiService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<SecureStorageService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<DioService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<StatusCheckerService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<PermissionHandlerService>(
        onMissingStub: OnMissingStub.returnDefault),
    MockSpec<ImagePickerService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<GoogleAuthService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<ImageDownloaderService>(
        onMissingStub: OnMissingStub.returnDefault),
    MockSpec<NotificationService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<SmartAuthService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<CourseService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<AudioPlayerService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<VoiceRecorderService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<InAppUpdateService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<VimeoService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<VimeoService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<UrlLauncherService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<UrlLauncherService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<PhoneCallerService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<LearnLessonService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<LearnService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<LearnService>(onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
  ],
)
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterAuthenticationService();
  getAndRegisterApiService();
  getAndRegisterSecureStorageService();
  getAndRegisterDioService();
  getAndRegisterStatusCheckerService();
  getAndRegisterPermissionHandlerService();
  getAndRegisterImagePickerService();
  getAndRegisterGoogleAuthService();
  getAndRegisterImageDownloaderService();
  getAndRegisterNotificationService();
  getAndRegisterSmartAuthService();
  getAndRegisterCourseService();
  getAndRegisterAudioPlayerService();
  getAndRegisterVoiceRecorderService();
  getAndRegisterInAppUpdateService();
  getAndRegisterVimeoService();
  getAndRegisterVimeoService();
  getAndRegisterUrlLauncherService();
  getAndRegisterUrlLauncherService();
  getAndRegisterPhoneCallerService();
  getAndRegisterLearnLessonService();
  getAndRegisterLearnService();
  getAndRegisterLearnService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(
    service.showCustomSheet<T, T>(
      enableDrag: anyNamed('enableDrag'),
      enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
      exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
      ignoreSafeArea: anyNamed('ignoreSafeArea'),
      isScrollControlled: anyNamed('isScrollControlled'),
      barrierDismissible: anyNamed('barrierDismissible'),
      additionalButtonTitle: anyNamed('additionalButtonTitle'),
      variant: anyNamed('variant'),
      title: anyNamed('title'),
      hasImage: anyNamed('hasImage'),
      imageUrl: anyNamed('imageUrl'),
      showIconInMainButton: anyNamed('showIconInMainButton'),
      mainButtonTitle: anyNamed('mainButtonTitle'),
      showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
      secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
      showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
      takesInput: anyNamed('takesInput'),
      barrierColor: anyNamed('barrierColor'),
      barrierLabel: anyNamed('barrierLabel'),
      customData: anyNamed('customData'),
      data: anyNamed('data'),
      description: anyNamed('description'),
    ),
  ).thenAnswer(
    (realInvocation) =>
        Future.value(showCustomSheetResponse ?? SheetResponse<T>()),
  );

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockAuthenticationService getAndRegisterAuthenticationService() {
  _removeRegistrationIfExists<AuthenticationService>();
  final service = MockAuthenticationService();
  locator.registerSingleton<AuthenticationService>(service);
  return service;
}

MockApiService getAndRegisterApiService() {
  _removeRegistrationIfExists<ApiService>();
  final service = MockApiService();
  locator.registerSingleton<ApiService>(service);
  return service;
}

MockSecureStorageService getAndRegisterSecureStorageService() {
  _removeRegistrationIfExists<SecureStorageService>();
  final service = MockSecureStorageService();
  locator.registerSingleton<SecureStorageService>(service);
  return service;
}

MockDioService getAndRegisterDioService() {
  _removeRegistrationIfExists<DioService>();
  final service = MockDioService();
  locator.registerSingleton<DioService>(service);
  return service;
}

MockStatusCheckerService getAndRegisterStatusCheckerService() {
  _removeRegistrationIfExists<StatusCheckerService>();
  final service = MockStatusCheckerService();
  locator.registerSingleton<StatusCheckerService>(service);
  return service;
}

MockPermissionHandlerService getAndRegisterPermissionHandlerService() {
  _removeRegistrationIfExists<PermissionHandlerService>();
  final service = MockPermissionHandlerService();
  locator.registerSingleton<PermissionHandlerService>(service);
  return service;
}

MockImagePickerService getAndRegisterImagePickerService() {
  _removeRegistrationIfExists<ImagePickerService>();
  final service = MockImagePickerService();
  locator.registerSingleton<ImagePickerService>(service);
  return service;
}

MockGoogleAuthService getAndRegisterGoogleAuthService() {
  _removeRegistrationIfExists<GoogleAuthService>();
  final service = MockGoogleAuthService();
  locator.registerSingleton<GoogleAuthService>(service);
  return service;
}

MockImageDownloaderService getAndRegisterImageDownloaderService() {
  _removeRegistrationIfExists<ImageDownloaderService>();
  final service = MockImageDownloaderService();
  locator.registerSingleton<ImageDownloaderService>(service);
  return service;
}

MockNotificationService getAndRegisterNotificationService() {
  _removeRegistrationIfExists<NotificationService>();
  final service = MockNotificationService();
  locator.registerSingleton<NotificationService>(service);
  return service;
}

MockSmartAuthService getAndRegisterSmartAuthService() {
  _removeRegistrationIfExists<SmartAuthService>();
  final service = MockSmartAuthService();
  locator.registerSingleton<SmartAuthService>(service);
  return service;
}

MockCourseService getAndRegisterCourseService() {
  _removeRegistrationIfExists<CourseService>();
  final service = MockCourseService();
  locator.registerSingleton<CourseService>(service);
  return service;
}

MockAudioPlayerService getAndRegisterAudioPlayerService() {
  _removeRegistrationIfExists<AudioPlayerService>();
  final service = MockAudioPlayerService();
  locator.registerSingleton<AudioPlayerService>(service);
  return service;
}

MockVoiceRecorderService getAndRegisterVoiceRecorderService() {
  _removeRegistrationIfExists<VoiceRecorderService>();
  final service = MockVoiceRecorderService();
  locator.registerSingleton<VoiceRecorderService>(service);
  return service;
}

MockInAppUpdateService getAndRegisterInAppUpdateService() {
  _removeRegistrationIfExists<InAppUpdateService>();
  final service = MockInAppUpdateService();
  locator.registerSingleton<InAppUpdateService>(service);
  return service;
}

MockVimeoService getAndRegisterVimeoService() {
  _removeRegistrationIfExists<VimeoService>();
  final service = MockVimeoService();
  locator.registerSingleton<VimeoService>(service);
  return service;
}

MockUrlLauncherService getAndRegisterUrlLauncherService() {
  _removeRegistrationIfExists<UrlLauncherService>();
  final service = MockUrlLauncherService();
  locator.registerSingleton<UrlLauncherService>(service);
  return service;
}

MockPhoneCallerService getAndRegisterPhoneCallerService() {
  _removeRegistrationIfExists<PhoneCallerService>();
  final service = MockPhoneCallerService();
  locator.registerSingleton<PhoneCallerService>(service);
  return service;
}

MockLearnService getAndRegisterLearnService() {
  _removeRegistrationIfExists<LearnService>();
  final service = MockLearnService();
  locator.registerSingleton<LearnService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
