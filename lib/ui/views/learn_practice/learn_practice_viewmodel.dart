import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class LearnPracticeViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();

  // In-app navigation
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  // In-app navigation
  void goTo(int page) {

    _currentIndex = page;
    rebuildUi();
  }

  void goBack() {
    if(_currentIndex == 0){
      pop();
    }else{
      _currentIndex--;
      rebuildUi();
    }

  }

  // Navigation
  void pop() => _navigationService.back();

}
