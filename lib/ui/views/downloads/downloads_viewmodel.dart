import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class DownloadsViewModel extends BaseViewModel {
  // Dependency injection
  final _navigationService = locator<NavigationService>();

  // Show download
  bool _showDownload = false;

  bool get showDownload => _showDownload;

  // Downloads
  final List<Map<String, dynamic>> _downloads = [
    {
      'size': '120 MB',
      'duration': '3h 46 m',
      'title': 'Duolingo English',
      'thumbnail': 'assets/images/image_1.png',
    },
    {
      'size': '79 MB',
      'duration': '1h 34 m',
      'title': 'IELTS Listening',
      'thumbnail': 'assets/images/image_1.png',
    },
    {
      'size': '120 MB',
      'duration': '3h 46 m',
      'title': 'Customer Service',
      'thumbnail': 'assets/images/image_1.png',
    },
  ];

  List<Map<String, dynamic>> get downloads => _downloads;

  // Show download
  void setShowDownload() {
    _showDownload = !_showDownload;
    rebuildUi();
  }

  // Navigation
  void pop() => _navigationService.back();
}
