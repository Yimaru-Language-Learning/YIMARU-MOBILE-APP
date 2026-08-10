import 'package:json_annotation/json_annotation.dart';

part 'proficiency_level.g.dart';

@JsonSerializable()
class ProficiencyLevel {
  final bool? passed;

  final String? level;

  final bool? completed;

  @JsonKey(name: 'next_level')
  final String? nextLevel;

  @JsonKey(name: 'points_max')
  final int? pointsMax;

  @JsonKey(name: 'pass_percent')
  final double? passPercent;

  @JsonKey(name: 'score_percent')
  final double? scorePercent;

  @JsonKey(name: 'points_earned')
  final int? pointsEarned;

  @JsonKey(name: 'level_attempted')
  final String? levelAttempted;

  @JsonKey(name: 'question_set_id')
  final int? questionSetId;

  @JsonKey(name: 'knowledge_level')
  final String? knowledgeLevel;

  @JsonKey(name: 'correct_questions')
  final int? correctQuestions;

  @JsonKey(name: 'gradable_questions')
  final int? gradableQuestions;

  @JsonKey(name: 'initial_assessment_completed')
  final bool? initialAssessmentCompleted;

  @JsonKey(name: 'skipped_ungradable_questions')
  final int? skippedUngradableQuestions;

  const ProficiencyLevel({
    this.level,
    this.passed,
    this.nextLevel,
    this.completed,
    this.pointsMax,
    this.passPercent,
    this.scorePercent,
    this.pointsEarned,
    this.questionSetId,
    this.knowledgeLevel,
    this.levelAttempted,
    this.correctQuestions,
    this.gradableQuestions,
    this.initialAssessmentCompleted,
    this.skippedUngradableQuestions,
  });

  factory ProficiencyLevel.fromJson(Map<String, dynamic> json) =>
      _$ProficiencyLevelFromJson(json);

  Map<String, dynamic> toJson() => _$ProficiencyLevelToJson(this);
}
