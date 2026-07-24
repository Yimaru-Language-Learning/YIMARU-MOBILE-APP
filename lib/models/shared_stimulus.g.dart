// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_stimulus.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedStimulus _$SharedStimulusFromJson(Map<String, dynamic> json) =>
    SharedStimulus(
      stimulus: (json['stimulus'] as List<dynamic>?)
          ?.map((e) => DynamicItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SharedStimulusToJson(SharedStimulus instance) =>
    <String, dynamic>{
      'stimulus': instance.stimulus,
    };
