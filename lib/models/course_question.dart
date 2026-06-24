import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/dynamic_payload.dart';

part 'course_question.g.dart';

@JsonSerializable()
class CourseQuestion {
  final int? id;

  final int? points;

  final String? status;

  @JsonKey(name: 'question_type')
  final String? questionType;

  @JsonKey(name: 'difficulty_level')
  final String? difficultyLevel;

  @JsonKey(name: 'dynamic_payload')
  final DynamicPayload? dynamicPayload;

  @JsonKey(name: 'question_type_definition_id')
  final int? questionTypeDefinitionId;

  const CourseQuestion(
      {this.id,
      this.status,
      this.points,
      this.questionType,
      this.dynamicPayload,
      this.difficultyLevel,
      this.questionTypeDefinitionId});

  factory CourseQuestion.fromJson(Map<String, dynamic> json) =>
      _$CourseQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$CourseQuestionToJson(this);
}
