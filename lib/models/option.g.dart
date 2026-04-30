// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      id: (json['id'] as num?)?.toInt(),
      optionText: json['option_text'] as String?,
      isCorrect: json['is_correct'] as bool?,
      optionOrder: (json['option_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'id': instance.id,
      'is_correct': instance.isCorrect,
      'option_text': instance.optionText,
      'option_order': instance.optionOrder,
    };
