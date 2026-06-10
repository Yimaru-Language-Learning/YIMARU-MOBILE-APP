// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DynamicItem _$DynamicItemFromJson(Map<String, dynamic> json) => DynamicItem(
      id: json['id'] as String,
      kind: json['kind'] as String,
      value: json['value'],
    );

Map<String, dynamic> _$DynamicItemToJson(DynamicItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'kind': instance.kind,
      'value': instance.value,
    };
