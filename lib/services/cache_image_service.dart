import 'package:flutter/cupertino.dart';

class CacheImageService {
  Future<void> cacheNetworkImage(
      {required String image, required BuildContext context}) async {
    await precacheImage(NetworkImage(image), context);
  }
}
