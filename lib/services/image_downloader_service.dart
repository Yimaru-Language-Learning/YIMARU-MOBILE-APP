import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../app/app.locator.dart';
import '../ui/common/app_constants.dart';
import 'dio_service.dart';

class ImageDownloaderService {
  final _service = locator<DioService>();

  Future<String> downloader(String? networkImage) async {
    late File image;

    late String profileImage;

    final Directory appDir = await getApplicationDocumentsDirectory();

    if (networkImage != null) {
      profileImage = networkImage.contains('https://lh3.googleusercontent.com')
          ? networkImage
          : '$kBaseUrl$networkImage';
    }

    final Response profileImageResponse = await _service.dio.get(
      profileImage,
      options: Options(
        followRedirects: false,
        responseType: ResponseType.bytes,
      ),
    );
    final imageName = basename(networkImage ?? '');
    final localImagePath = join(appDir.path, imageName);
    image = File(localImagePath);
    image.writeAsBytes(profileImageResponse.data);

    return image.path;
  }
}
