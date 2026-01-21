// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'option.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Option _$OptionFromJson(Map<String, dynamic> json) => Option(
      optionText: json['option_text'] as String?,
      questionId: (json['question_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$OptionToJson(Option instance) => <String, dynamic>{
      'question_id': instance.questionId,
      'option_text': instance.optionText,
    };
