import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState>  {
  SettingsCubit()
      : super(
            SettingsLoaded(appNotifications: false, emailNotifications: false));

  void toggleAppNotifications(bool newValue) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(currentState.copyWith(appNotifications: newValue));
    }
  }

  void toggleEmailNotifications(bool newValue) {
    if (state is SettingsLoaded) {
      final currentState = state as SettingsLoaded;
      emit(currentState.copyWith(emailNotifications: newValue));
    }
  }
}
