import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/dynamic_payload.dart';

part 'practice_question.g.dart';

@JsonSerializable()
class PracticeQuestion {
  final int? id;

  final int? points;

  final String? status;

  @JsonKey(name: 'question_type')
  final String? questionType;

  @JsonKey(name: 'question_text')
  final String? questionText;

  @JsonKey(name: 'difficulty_level')
  final String? difficultyLevel;

  @JsonKey(name: 'stimulus_block_key')
  final String? stimulusBlockKey;

  @JsonKey(name: 'shared_stimulus')
  final DynamicPayload? sharedStimulus;

  @JsonKey(name: 'dynamic_payload')
  final DynamicPayload? dynamicPayload;

  @JsonKey(name: 'question_type_definition_id')
  final int? questionTypeDefinitionId;

  const PracticeQuestion(
      {this.id,
      this.status,
      this.points,
      this.questionType,
      this.questionText,
      this.sharedStimulus,
      this.dynamicPayload,
      this.difficultyLevel,
      this.stimulusBlockKey,
      this.questionTypeDefinitionId});

  factory PracticeQuestion.fromJson(Map<String, dynamic> json) =>
      _$PracticeQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$PracticeQuestionToJson(this);
}
