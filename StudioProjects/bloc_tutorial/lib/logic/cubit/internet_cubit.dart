import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:meta/meta.dart';

import '../../constants/enums.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  late StreamSubscription _internetStreamSubscription;

  final Connectivity _connectivity = Connectivity();

  InternetCubit() : super(InternetLoading()) {
    _monitorInternetConnection();
  }

  void emitInternetConnected(ConnectionType connectionType) =>
      emit(InternetConnected(connectionType: connectionType));

  void emitInternetDisconnected() => emit(InternetDisconnected());

  void _monitorInternetConnection() {
    _internetStreamSubscription =
        _connectivity.onConnectivityChanged.listen((connectivityResult) {
      if (connectivityResult.last == ConnectivityResult.wifi) {
        emitInternetConnected(ConnectionType.wifi);
      } else if (connectivityResult.last == ConnectivityResult.mobile) {
        emitInternetConnected(ConnectionType.mobile);
      } else if (connectivityResult.last == ConnectivityResult.vpn) {
        emitInternetConnected(ConnectionType.vpn);
      } else if (connectivityResult.last == ConnectivityResult.none) {
        emitInternetDisconnected();
      }
    });
  }

  @override
  Future<void> close() {
    _internetStreamSubscription.cancel();
    return super.close();
  }
}
