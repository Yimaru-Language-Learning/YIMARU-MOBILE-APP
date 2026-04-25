import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/option.dart';

part 'learn_question.g.dart';

@JsonSerializable()
class LearnQuestion {
  final int? id;

  final int? points;

  @JsonKey(name: 'set_id')
  final int? setId;

  @JsonKey(name: 'question_id')
  final int? questionId;

  @JsonKey(name: 'voice_prompt')
  final String? voicePrompt;

  @JsonKey(name: 'question_text')
  final String? questionText;

  @JsonKey(name: 'display_order')
  final int? displayOrder;

  @JsonKey(name: 'question_type')
  final String? questionType;

  @JsonKey(name: 'question_status')
  final String? questionStatus;

  @JsonKey(name: 'audio_correct_answer_text')
  final String? audioCorrectAnswerText;

  @JsonKey(name: 'sample_answer_voice_prompt')
  final String? sampleAnswerVoicePrompt;

  const LearnQuestion(
      {this.id,
      this.setId,
      this.points,
      this.questionId,
      this.voicePrompt,
      this.questionText,
      this.questionType,
      this.displayOrder,
      this.questionStatus,
      this.audioCorrectAnswerText,
      this.sampleAnswerVoicePrompt});

  factory LearnQuestion.fromJson(Map<String, dynamic> json) =>
      _$LearnQuestionFromJson(json);

  Map<String, dynamic> toJson() => _$LearnQuestionToJson(this);
}
