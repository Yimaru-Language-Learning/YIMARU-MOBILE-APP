import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/api_service.dart';

class PdfViewModel extends BaseViewModel {
  // Dependency injection
  final _apiService = locator<ApiService>();

  final _navigationService = locator<NavigationService>();

  // Url
  /*String? _url;

   String? get url => _url;*/

  // Navigation
  void pop() => _navigationService.back();

  // Remote api
  /*Future<void> openPdf(
 String url) async =>
      await runBusyFuture(_openPdf(url),
          busyObject: StateObjects.openPdf);

  Future<void> _openPdf(
   String url) async {
    Map<String, dynamic> data = {'reference': url};
    Map<String, dynamic> response = await _apiService.refreshObject(data);
    if (response['status'] == ResponseStatus.success) {
      RefreshObject object = response['data'] as RefreshObject;
      _url = object.url;

    }
  }*/
}
