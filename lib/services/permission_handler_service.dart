import 'package:permission_handler/permission_handler.dart';

import '../ui/common/ui_helpers.dart';

class PermissionHandlerService {
  // Check permission category
  Future<PermissionStatus> requestPermission(
      Permission requestedPermission) async {
    if (requestedPermission == Permission.camera) {
      return await request(Permission.camera);
    }
    if (requestedPermission == Permission.storage) {
      return await request(Permission.storage);
    }
    if (requestedPermission == Permission.mediaLibrary) {
      return await request(Permission.mediaLibrary);
    }
    if (requestedPermission == Permission.microphone) {
      return await request(Permission.microphone);
    }
    return PermissionStatus.denied;
  }

  // Request permission
  Future<PermissionStatus> request(Permission permission) async {
    PermissionStatus status = await permission.status;

    if (status.isDenied) {
      status = await permission.request();
    }

    if (!status.isGranted) {
      showErrorToast('Permission Denied');
    }

    return status;
  }
}
