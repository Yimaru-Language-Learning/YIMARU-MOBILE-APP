import 'package:json_annotation/json_annotation.dart';

part 'assessment.g.dart';

@JsonSerializable()
class Assessment {
  final int? id;

  final String? title;

  final String? status;

  final String? description;

  @JsonKey(name: 'set_type')
  final String? setType;

  @JsonKey(name: 'passing_score')
  final int? passingScore;

  @JsonKey(name: 'shuffle_questions')
  final bool? shuffleQuestions;

  const Assessment(
      {this.id,
      this.title,
      this.status,
      this.setType,
      this.description,
      this.passingScore,
      this.shuffleQuestions});

  factory Assessment.fromJson(Map<String, dynamic> json) =>
      _$AssessmentFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentToJson(this);
}
