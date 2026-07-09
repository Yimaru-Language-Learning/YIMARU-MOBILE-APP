import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class CacheImageService {
  Future<void> cacheNetworkImage(
      {required String image, required BuildContext context}) async {
    await precacheImage(CachedNetworkImageProvider(image), context);
  }

  Future<void> cacheImage(String image) async {
    await DefaultCacheManager().downloadFile(image);
  }
}
