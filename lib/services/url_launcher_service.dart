import 'package:url_launcher/url_launcher.dart';

class UrlLauncherService {
  Future<void> launchUri(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      launchUrl(uri);
    }
  }
}
