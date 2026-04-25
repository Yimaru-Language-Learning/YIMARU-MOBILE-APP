// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnQuestion _$LearnQuestionFromJson(Map<String, dynamic> json) =>
    LearnQuestion(
      id: (json['id'] as num?)?.toInt(),
      setId: (json['set_id'] as num?)?.toInt(),
      points: (json['points'] as num?)?.toInt(),
      questionId: (json['question_id'] as num?)?.toInt(),
      voicePrompt: json['voice_prompt'] as String?,
      questionText: json['question_text'] as String?,
      questionType: json['question_type'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
      questionStatus: json['question_status'] as String?,
      audioCorrectAnswerText: json['audio_correct_answer_text'] as String?,
      sampleAnswerVoicePrompt: json['sample_answer_voice_prompt'] as String?,
    );

Map<String, dynamic> _$LearnQuestionToJson(LearnQuestion instance) =>
    <String, dynamic>{
      'id': instance.id,
      'points': instance.points,
      'set_id': instance.setId,
      'question_id': instance.questionId,
      'voice_prompt': instance.voicePrompt,
      'question_text': instance.questionText,
      'display_order': instance.displayOrder,
      'question_type': instance.questionType,
      'question_status': instance.questionStatus,
      'audio_correct_answer_text': instance.audioCorrectAnswerText,
      'sample_answer_voice_prompt': instance.sampleAnswerVoicePrompt,
    };
