// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PracticeQuestion _$PracticeQuestionFromJson(Map<String, dynamic> json) =>
    PracticeQuestion(
      id: (json['id'] as num?)?.toInt(),
      status: json['status'] as String?,
      points: (json['points'] as num?)?.toInt(),
      questionType: json['question_type'] as String?,
      questionText: json['question_text'] as String?,
      sharedStimulus: (json['shared_stimulus'] as List<dynamic>?)
          ?.map((e) => SharedStimulus.fromJson(e as Map<String, dynamic>))
          .toList(),
      dynamicPayload: json['dynamic_payload'] == null
          ? null
          : DynamicPayload.fromJson(
              json['dynamic_payload'] as Map<String, dynamic>),
      difficultyLevel: json['difficulty_level'] as String?,
      stimulusBlockKey: json['stimulus_block_key'] as String?,
      questionTypeDefinitionId:
          (json['question_type_definition_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PracticeQuestionToJson(PracticeQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'points': instance.points,
      'status': instance.status,
      'question_type': instance.questionType,
      'question_text': instance.questionText,
      'difficulty_level': instance.difficultyLevel,
      'stimulus_block_key': instance.stimulusBlockKey,
      'dynamic_payload': instance.dynamicPayload,
      'shared_stimulus': instance.sharedStimulus,
      'question_type_definition_id': instance.questionTypeDefinitionId,
    };
