import 'package:json_annotation/json_annotation.dart';

part 'assessment_session.g.dart';

@JsonSerializable()
class AssessmentSession {
  final bool? completed;

  @JsonKey(name: 'next_level')
  final String? nextLevel;

  @JsonKey(name: 'published_levels')
  final List<String>? publishedLevels;

  @JsonKey(name: 'initial_assessment_completed')
  final bool? initialAssessmentCompleted;

  const AssessmentSession(
      {this.completed,
      this.nextLevel,
      this.publishedLevels,
      this.initialAssessmentCompleted});

  factory AssessmentSession.fromJson(Map<String, dynamic> json) =>
      _$AssessmentSessionFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentSessionToJson(this);
}
