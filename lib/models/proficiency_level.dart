import 'package:json_annotation/json_annotation.dart';

part 'proficiency_level.g.dart';

@JsonSerializable()
class ProficiencyLevel {
  final String? level;

  @JsonKey(name: 'points_max')
  final int? pointsMax;

  @JsonKey(name: 'score_percent')
  final double? scorePercent;
  @JsonKey(name: 'points_earned')
  final int? pointsEarned;

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

  const ProficiencyLevel(
      {this.level,
      this.pointsMax,
      this.scorePercent,
      this.pointsEarned,
      this.questionSetId,
      this.knowledgeLevel,
      this.correctQuestions,
      this.gradableQuestions,
      this.initialAssessmentCompleted,
      this.skippedUngradableQuestions});


  factory ProficiencyLevel.fromJson(Map<String, dynamic> json) => _$ProficiencyLevelFromJson(json);

  Map<String, dynamic> toJson() => _$ProficiencyLevelToJson(this);
}
