// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PracticeQuestion _$PracticeQuestionFromJson(Map<String, dynamic> json) =>
    PracticeQuestion(
      id: (json['id'] as num?)?.toInt(),
      tips: json['tips'] as String?,
      setId: (json['set_id'] as num?)?.toInt(),
      points: (json['points'] as num?)?.toInt(),
      questionId: (json['question_id'] as num?)?.toInt(),
      questionText: json['question_text'] as String?,
      questionType: json['question_type'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
      questionStatus: json['question_status'] as String?,
    );

Map<String, dynamic> _$PracticeQuestionToJson(PracticeQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'points': instance.points,
      'tips': instance.tips,
      'set_id': instance.setId,
      'question_id': instance.questionId,
      'display_order': instance.displayOrder,
      'question_text': instance.questionText,
      'question_type': instance.questionType,
      'question_status': instance.questionStatus,
    };
