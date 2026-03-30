import 'package:json_annotation/json_annotation.dart';

part 'practice_question.g.dart';

@JsonSerializable()
class PracticeQuestion {
  final int? id;

  final int? points;

  final String? tips;

  @JsonKey(name: 'set_id')
  final int? setId;

  @JsonKey(name: 'question_id')
  final int? questionId;

  @JsonKey(name: 'display_order')
  final int? displayOrder;

  @JsonKey(name: 'question_text')
  final String? questionText;

  @JsonKey(name: 'question_type')
  final String? questionType;

  @JsonKey(name: 'question_status')
  final String? questionStatus;

  const PracticeQuestion(
      {this.id,
      this.tips,
      this.setId,
      this.points,
      this.questionId,
      this.questionText,
      this.questionType,
      this.displayOrder,
      this.questionStatus});

  factory PracticeQuestion.fromJson(Map<String, dynamic> json) =>
      _$PracticeQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$PracticeQuestionToJson(this);
}
