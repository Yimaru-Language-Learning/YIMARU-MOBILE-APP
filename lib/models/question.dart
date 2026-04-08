import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/option.dart';
part 'question.g.dart';

@JsonSerializable()
class Question {
  final int? id;

  final int? points;

  final String? status;

  final List<Option>? options;

  @JsonKey(name: 'question_type')
  final String? questionType;

  @JsonKey(name: 'question_text')
  final String? questionText;

  @JsonKey(name: 'difficulty_level')
  final String? difficultyLevel;

  const Question({
    this.id,
    this.points,
    this.status,
    this.options,
    this.questionText,
    this.questionType,
    this.difficultyLevel,
  });

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
