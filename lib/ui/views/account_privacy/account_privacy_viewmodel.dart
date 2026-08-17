import 'package:easy_localization/easy_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/api_service.dart';
import 'package:yimaru_app/services/authentication_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';
import 'package:yimaru_app/ui/common/translations/locale_keys.g.dart';
import 'package:yimaru_app/ui/common/ui_helpers.dart';

import '../../../app/app.locator.dart';
import '../../../services/localization_service.dart';
import '../../common/app_colors.dart';

class AccountPrivacyViewModel extends ReactiveViewModel {
  AccountPrivacyViewModel({
    void Function(String)? successNotifier,
    void Function(String)? errorNotifier,
  })  : _successNotifier = successNotifier ?? showSuccessToast,
        _errorNotifier = errorNotifier ?? showErrorToast;

  final void Function(String) _successNotifier;
  final void Function(String) _errorNotifier;

  // Dependency injection
  final _apiService = locator<ApiService>();

  final _dialogService = locator<DialogService>();

  final _navigationService = locator<NavigationService>();

  final _authenticationService = locator<AuthenticationService>();

  final _localizationService = locator<LocalizationService>();

  @override
  List<ListenableServiceMixin> get listenableServices => [_localizationService];

  // Languages
  Map<String, dynamic> get _selectedLanguage =>
      _localizationService.selectedLanguage;

  Map<String, dynamic> get selectedLanguage => _selectedLanguage;

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToTerms() async =>
      await _navigationService.navigateToTermsAndConditionsView();

  Future<void> navigateToLanguage() async =>
      await _navigationService.navigateToLanguageView();

  Future<void> navigateToPrivacyPolicy() async =>
      await _navigationService.navigateToPrivacyPolicyView();

  // Account deletion
  Future<void> deleteAccount() async {
    final confirmed = await _showDeleteAccountDialog();
    if (confirmed != true) return;

    await runBusyFuture(
      _requestAccountDeletion(),
      busyObject: StateObjects.accountDeletion,
    );
  }

  Future<bool?> _showDeleteAccountDialog() async {
    final response = await _dialogService.showDialog(
      barrierDismissible: false,
      title: LocaleKeys.delete_account.tr(),
      description: LocaleKeys.delete_account_confirmation.tr(),
      cancelTitle: LocaleKeys.no.tr(),
      cancelTitleColor: kcDarkGrey,
      buttonTitle: LocaleKeys.delete_account.tr(),
      buttonTitleColor: kcRed,
    );

    return response?.confirmed;
  }

  Future<void> _requestAccountDeletion() async {
    final response = await _apiService.requestAccountDeletion();

    if (response['status'] == ResponseStatus.success) {
      _successNotifier(LocaleKeys.account_deletion_requested.tr());
      await _authenticationService.logout();
      await _navigationService.clearStackAndShow(Routes.loginView);
      return;
    }

    _errorNotifier(LocaleKeys.account_deletion_failed.tr());
  }
}
