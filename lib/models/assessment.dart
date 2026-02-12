import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/option.dart';
part 'assessment.g.dart';

@JsonSerializable()
class Assessment {
  final int? id;

  final int? points;

  final String? status;

  @JsonKey(name: 'question_type')
  final String? questionType;

  @JsonKey(name: 'question_text')
  final String? questionText;

  @JsonKey(name: 'difficulty_level')
  final String? difficultyLevel;

  final List<Option>? options;

  const Assessment({
    this.id,
    this.points,
    this.status,
    this.options,
    this.questionText,
    this.questionType,
    this.difficultyLevel,
  });

  factory Assessment.fromJson(Map<String, dynamic> json) =>
      _$AssessmentFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentToJson(this);
}
