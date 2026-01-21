// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'counter_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CounterState _$CounterStateFromJson(Map<String, dynamic> json) => CounterState(
      counterValue: (json['counterValue'] as num).toInt(),
      wasIncremented: json['wasIncremented'] as bool,
    );

Map<String, dynamic> _$CounterStateToJson(CounterState instance) =>
    <String, dynamic>{
      'counterValue': instance.counterValue,
      'wasIncremented': instance.wasIncremented,
    };
