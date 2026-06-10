// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_payload.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicPayload _$DynamicPayloadFromJson(Map<String, dynamic> json) =>
    DynamicPayload(
      stimulus: (json['stimulus'] as List<dynamic>?)
          ?.map((e) => DynamicItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      response: (json['response'] as List<dynamic>?)
          ?.map((e) => DynamicItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DynamicPayloadToJson(DynamicPayload instance) =>
    <String, dynamic>{
      'stimulus': instance.stimulus,
      'response': instance.response,
    };
