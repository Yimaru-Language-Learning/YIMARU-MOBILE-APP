// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Question _$QuestionFromJson(Map<String, dynamic> json) => Question(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      points: (json['points'] as num?)?.toInt(),
      isActive: json['is_active'] as bool?,
      description: json['description'] as String?,
      questionType: json['question_type'] as String?,
      difficultyLevel: json['difficulty_level'] as String?,
    );

Map<String, dynamic> _$QuestionToJson(Question instance) => <String, dynamic>{
      'id': instance.id,
      'points': instance.points,
      'title': instance.title,
      'description': instance.description,
      'is_active': instance.isActive,
      'question_type': instance.questionType,
      'difficulty_level': instance.difficultyLevel,
    };
