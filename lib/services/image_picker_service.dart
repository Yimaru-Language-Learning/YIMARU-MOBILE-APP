import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:yimaru_app/services/permission_handler_service.dart';

import '../app/app.locator.dart';
import '../ui/common/ui_helpers.dart';

class ImagePickerService {
  // Dependency injection
  final _permissionHandler = locator<PermissionHandlerService>();

  // Initialization
  final ImagePicker _picker = ImagePicker();

  // Pick image from gallery
  Future<String?> gallery() async {
    try {
      PermissionStatus status =
          await _permissionHandler.requestPermission(Permission.mediaLibrary);

      if (status == PermissionStatus.granted) {
        final XFile? pickedFile = await _picker.pickImage(
            source: ImageSource.gallery, maxWidth: 600, maxHeight: 600);

        if (pickedFile == null) {
          showErrorToast('Please select a picture');
          return null;
        } else {
          return pickedFile.path;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  // Pick image from camera
  Future<String?> camera() async {
    try {
      PermissionStatus status =
          await _permissionHandler.requestPermission(Permission.camera);

      if (status == PermissionStatus.granted) {
        final XFile? pickedFile = await _picker.pickImage(
            source: ImageSource.camera, maxWidth: 600, maxHeight: 600);

        if (pickedFile == null) {
          showErrorToast('Please take a picture');
          return null;
        } else {
          return pickedFile.path;
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
