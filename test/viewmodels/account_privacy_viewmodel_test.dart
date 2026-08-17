import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:yimaru_app/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/services/localization_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/views/account_privacy/account_privacy_viewmodel.dart';

class _FakeDialogService extends DialogService {
  _FakeDialogService({required this.confirmed});

  bool confirmed;
  int callCount = 0;

  @override
  Future<DialogResponse?> showDialog({
    String? title,
    String? description,
    String? cancelTitle,
    Color? cancelTitleColor,
    String buttonTitle = 'Ok',
    Color? buttonTitleColor,
    bool barrierDismissible = false,
    RouteSettings? routeSettings,
    GlobalKey<NavigatorState>? navigatorKey,
    DialogPlatform? dialogPlatform,
  }) async {
    callCount++;
    return DialogResponse(confirmed: confirmed);
  }
}

class _FakeApiService implements ApiService {
  _FakeApiService(this.response);

  Map<String, dynamic> response;
  int deletionRequestCount = 0;

  @override
  Future<Map<String, dynamic>> requestAccountDeletion() async {
    deletionRequestCount++;
    return response;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeAuthenticationService implements AuthenticationService {
  int logoutCount = 0;

  @override
  Future<void> logout() async => logoutCount++;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeNavigationService implements NavigationService {
  String? clearedToRoute;

  @override
  Future<T?>? clearStackAndShow<T>(
    String routeName, {
    dynamic arguments,
    int? id,
    Map<String, String>? parameters,
  }) async {
    clearedToRoute = routeName;
    return null;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _FakeLocalizationService implements LocalizationService {
  final List<VoidCallback> _listeners = [];

  @override
  Map<String, dynamic> get selectedLanguage => {
        'code': 'en',
        'language': 'English',
      };

  @override
  void addListener(VoidCallback listener) => _listeners.add(listener);

  @override
  void removeListener(VoidCallback listener) => _listeners.remove(listener);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  group('AccountPrivacyViewModel Tests -', () {
    late _FakeDialogService dialogService;
    late _FakeApiService apiService;
    late _FakeAuthenticationService authenticationService;
    late _FakeNavigationService navigationService;
    late List<String> successMessages;
    late List<String> errorMessages;

    AccountPrivacyViewModel buildViewModel() => AccountPrivacyViewModel(
          successNotifier: successMessages.add,
          errorNotifier: errorMessages.add,
        );

    void registerFakes({
      required bool confirmed,
      required Map<String, dynamic> apiResponse,
    }) {
      dialogService = _FakeDialogService(confirmed: confirmed);
      apiService = _FakeApiService(apiResponse);
      authenticationService = _FakeAuthenticationService();
      navigationService = _FakeNavigationService();

      locator.registerSingleton<DialogService>(dialogService);
      locator.registerSingleton<ApiService>(apiService);
      locator.registerSingleton<AuthenticationService>(authenticationService);
      locator.registerSingleton<NavigationService>(navigationService);
      locator.registerSingleton<LocalizationService>(
        _FakeLocalizationService(),
      );
    }

    setUp(() {
      successMessages = [];
      errorMessages = [];
    });

    tearDown(() async => locator.reset());

    test('does not call the API when deletion is not confirmed', () async {
      registerFakes(
        confirmed: false,
        apiResponse: {'status': ResponseStatus.success},
      );

      await buildViewModel().deleteAccount();

      expect(dialogService.callCount, 1);
      expect(apiService.deletionRequestCount, 0);
      expect(authenticationService.logoutCount, 0);
    });

    test('logs out and opens login after a successful request', () async {
      registerFakes(
        confirmed: true,
        apiResponse: {'status': ResponseStatus.success},
      );

      final viewModel = buildViewModel();
      await viewModel.deleteAccount();

      expect(apiService.deletionRequestCount, 1);
      expect(successMessages, hasLength(1));
      expect(errorMessages, isEmpty);
      expect(authenticationService.logoutCount, 1);
      expect(navigationService.clearedToRoute, Routes.loginView);
      expect(viewModel.busy(StateObjects.accountDeletion), isFalse);
    });

    test('keeps the user signed in when the request fails', () async {
      registerFakes(
        confirmed: true,
        apiResponse: {'status': ResponseStatus.failure},
      );

      await buildViewModel().deleteAccount();

      expect(apiService.deletionRequestCount, 1);
      expect(successMessages, isEmpty);
      expect(errorMessages, hasLength(1));
      expect(authenticationService.logoutCount, 0);
      expect(navigationService.clearedToRoute, isNull);
    });
  });
}
