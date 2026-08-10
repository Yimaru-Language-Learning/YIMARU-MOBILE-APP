// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'proficiency_level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProficiencyLevel _$ProficiencyLevelFromJson(Map<String, dynamic> json) =>
    ProficiencyLevel(
      level: json['level'] as String?,
      passed: json['passed'] as bool?,
      nextLevel: json['next_level'] as String?,
      completed: json['completed'] as bool?,
      pointsMax: (json['points_max'] as num?)?.toInt(),
      passPercent: (json['pass_percent'] as num?)?.toDouble(),
      scorePercent: (json['score_percent'] as num?)?.toDouble(),
      pointsEarned: (json['points_earned'] as num?)?.toInt(),
      questionSetId: (json['question_set_id'] as num?)?.toInt(),
      knowledgeLevel: json['knowledge_level'] as String?,
      levelAttempted: json['level_attempted'] as String?,
      correctQuestions: (json['correct_questions'] as num?)?.toInt(),
      gradableQuestions: (json['gradable_questions'] as num?)?.toInt(),
      initialAssessmentCompleted: json['initial_assessment_completed'] as bool?,
      skippedUngradableQuestions:
          (json['skipped_ungradable_questions'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ProficiencyLevelToJson(ProficiencyLevel instance) =>
    <String, dynamic>{
      'passed': instance.passed,
      'level': instance.level,
      'completed': instance.completed,
      'next_level': instance.nextLevel,
      'points_max': instance.pointsMax,
      'pass_percent': instance.passPercent,
      'score_percent': instance.scorePercent,
      'points_earned': instance.pointsEarned,
      'level_attempted': instance.levelAttempted,
      'question_set_id': instance.questionSetId,
      'knowledge_level': instance.knowledgeLevel,
      'correct_questions': instance.correctQuestions,
      'gradable_questions': instance.gradableQuestions,
      'initial_assessment_completed': instance.initialAssessmentCompleted,
      'skipped_ungradable_questions': instance.skippedUngradableQuestions,
    };
