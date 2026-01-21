part of 'internet_cubit.dart';

@immutable
sealed class InternetState {}

final class InternetLoading extends InternetState {}

final class InternetConnected extends InternetState {
  final ConnectionType connectionType;

  InternetConnected({required this.connectionType});
  @override
  String toString() {
    // TODO: implement toString
    return "InternetConnected($connectionType)";
  }
}

final class InternetDisconnected extends InternetState {

  @override
  String toString() {
    // TODO: implement toString
    return "InternetDisconnected";
  }
}
