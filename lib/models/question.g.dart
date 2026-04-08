// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: (json['id'] as num?)?.toInt(),
      points: (json['points'] as num?)?.toInt(),
      status: json['status'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      questionText: json['question_text'] as String?,
      questionType: json['question_type'] as String?,
      difficultyLevel: json['difficulty_level'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'points': instance.points,
      'status': instance.status,
      'options': instance.options,
      'question_type': instance.questionType,
      'question_text': instance.questionText,
      'difficulty_level': instance.difficultyLevel,
    };
