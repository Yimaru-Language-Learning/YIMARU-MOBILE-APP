import 'dart:async';

import 'package:bloc_tutorial/constants/enums.dart';
import 'package:bloc_tutorial/logic/cubit/internet_cubit.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> with HydratedMixin {
  CounterCubit() : super(CounterState(counterValue: 0, wasIncremented: false));

  void increment() => emit(
        CounterState(
            counterValue: state.counterValue + 1, wasIncremented: true),
      );

  void decrement() => emit(
        CounterState(
            counterValue: state.counterValue - 1, wasIncremented: false),
      );



  @override
  Map<String, dynamic>? toJson(CounterState state) {
    return state.toJson();
  }

  @override
  CounterState? fromJson(Map<String, dynamic> json) {
    return CounterState.fromJson(json);
  }
}
