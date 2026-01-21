part of 'settings_cubit.dart';

@immutable
sealed class SettingsState extends Equatable {}

final class SettingsLoaded extends SettingsState {
  final bool appNotifications;
  final bool emailNotifications;

  SettingsLoaded({
    required this.appNotifications,
    required this.emailNotifications,
  });

  SettingsLoaded copyWith({
    appNotifications,
    emailNotifications,
  }) {
    return SettingsLoaded(
      appNotifications: appNotifications ?? this.appNotifications,
      emailNotifications: emailNotifications ?? this.emailNotifications,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [appNotifications, appNotifications];

  @override
  String toString() {
    // TODO: implement toString
    return "SettingsLoaded(appNotifications : $appNotifications, emailNotifications : $emailNotifications)";
  }
}
