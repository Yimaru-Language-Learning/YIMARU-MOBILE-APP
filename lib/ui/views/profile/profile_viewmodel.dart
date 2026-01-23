import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:yimaru_app/app/app.router.dart';
import 'package:yimaru_app/services/image_picker_service.dart';
import 'package:yimaru_app/ui/common/enmus.dart';

import '../../../app/app.locator.dart';
import '../../../models/user_model.dart';
import '../../../services/authentication_service.dart';

class ProfileViewModel extends ReactiveViewModel {
  final _navigationService = locator<NavigationService>();

  final _imagePickerService = locator<ImagePickerService>();

  final _authenticationService = locator<AuthenticationService>();

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [_authenticationService];

  // Current user
  UserModel? get user =>  _authenticationService.user;

  // Image picker
  Future<void> openCamera() async => runBusyFuture(_openCamera(),busyObject: StateObjects.profileImage);

  Future<void> _openCamera()async{
    String? image = await _imagePickerService.camera();
    if (image != null) {
      await _authenticationService.saveProfileImage(image);
    }
    pop();
  }

  Future<void> openGallery() async => runBusyFuture(_openGallery(),busyObject: StateObjects.profileImage);


  Future<void> _openGallery() async {
    String? image = await _imagePickerService.gallery();
    if (image != null) {
      await _authenticationService.saveProfileImage(image);
    }
    pop();
  }

  // Logout
  Future<void> logOut() async {
    await _authenticationService.logOut();
    await _navigationService.replaceWithLoginView();
  }

  // Navigation
  void pop() => _navigationService.back();

  Future<void> navigateToProfileDetail() async =>
      await _navigationService.navigateToProfileDetailView();

  Future<void> navigateToDownloads() async =>
      await _navigationService.navigateToDownloadsView();

  Future<void> navigateToProgress() async =>
      await _navigationService.navigateToProgressView();

  Future<void> navigateToAccountPrivacy() async =>
      await _navigationService.navigateToAccountPrivacyView();

  Future<void> navigateToSupport() async =>
      await _navigationService.navigateToSupportView();
}
