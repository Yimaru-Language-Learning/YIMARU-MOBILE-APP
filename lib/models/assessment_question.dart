import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/option.dart';
part 'assessment_question.g.dart';

@JsonSerializable()
class AssessmentQuestion {
  final int? id;

  final int? points;

  final String? status;

  final List<Option>? options;

  @JsonKey(name: 'question_type')
  final String? questionType;

  @JsonKey(name: 'question_text')
  final String? questionText;

  const AssessmentQuestion({
    this.id,
    this.points,
    this.status,
    this.options,
    this.questionText,
    this.questionType,
  });

  factory AssessmentQuestion.fromJson(Map<String, dynamic> json) =>
      _$AssessmentQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentQuestionToJson(this);
}
