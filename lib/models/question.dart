import 'package:json_annotation/json_annotation.dart';
part 'question.g.dart';

@JsonSerializable()
class Question {
  final int? id;

  final int? points;

  final String? title;

  final String? description;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'question_type')
  final String? questionType;

  @JsonKey(name: 'difficulty_level')
  final String? difficultyLevel;

  const Question(
      {this.id,
      this.title,
      this.points,
      this.isActive,
      this.description,
      this.questionType,
      this.difficultyLevel});

  factory Question.fromJson(Map<String, dynamic> json) =>
      _$QuestionFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionToJson(this);
}
