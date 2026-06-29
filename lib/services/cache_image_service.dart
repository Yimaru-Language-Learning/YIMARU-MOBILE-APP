import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class CacheImageService {
Future<void> cacheNetworkImage(
      {required String image, required BuildContext context}) async {
    await precacheImage(CachedNetworkImageProvider(image), context);
  }
}
