import 'package:json_annotation/json_annotation.dart';

part 'counter_state.g.dart';

@JsonSerializable()
class CounterState {
  final int counterValue;
  final bool wasIncremented;

  CounterState({required this.counterValue,required this.wasIncremented});

  factory CounterState.fromJson(Map<String, dynamic> json) =>
      _$CounterStateFromJson(json);

  Map<String, dynamic> toJson() => _$CounterStateToJson(this);

  @override
  String toString() {
    return "CounterState(counterValue : $counterValue, wasIncremented : $wasIncremented)";
  }
}
