import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../app/app.locator.dart';
import 'api_service.dart';
import 'dio_service.dart';

class ImageDownloaderService {
  // Dependency injection
  final _service = locator<DioService>();

  final _apiService = locator<ApiService>();

  final Dio _dio = Dio();

  // Image downloader
  Future<String?> downloader(String? networkImage) async {
    try {
      File? image;

      final Directory appDir = await getApplicationDocumentsDirectory();

      /*     String? profileImage = networkImage;

      Map<String, dynamic> data = {'reference': profileImage};
      Map<String, dynamic> response = await _apiService.refreshObject(data);

      if (response['status'] == ResponseStatus.success) {
        RefreshObject object = response['data'] as RefreshObject;

        profileImage = object.url;
      }*/

      if (networkImage != null) {
        final Response profileImageResponse = await _dio.get<List<int>>(
          networkImage,
          options: Options(
            responseType: ResponseType.bytes,
          ),
        );
        final localImagePath = join(appDir.path, 'profile.jpg');
        image = File(localImagePath);
        image.writeAsBytes(profileImageResponse.data);

        return image.path;
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
