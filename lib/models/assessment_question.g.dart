// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentQuestion _$AssessmentQuestionFromJson(Map<String, dynamic> json) =>
    AssessmentQuestion(
      id: (json['id'] as num?)?.toInt(),
      points: (json['points'] as num?)?.toInt(),
      status: json['status'] as String?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e as Map<String, dynamic>))
          .toList(),
      questionText: json['question_text'] as String?,
      questionType: json['question_type'] as String?,
    );

Map<String, dynamic> _$AssessmentQuestionToJson(AssessmentQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'points': instance.points,
      'status': instance.status,
      'options': instance.options,
      'question_type': instance.questionType,
      'question_text': instance.questionText,
    };
