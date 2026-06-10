import 'package:json_annotation/json_annotation.dart';

part 'course_practice.g.dart';

@JsonSerializable()
class CoursePractice {
  final int? id;

  final String? title;

  @JsonKey(name: 'lesson_id')
  final int? lessonId;

  @JsonKey(name: 'persona_id')
  final int? personaId;

  @JsonKey(name: 'quick_tips')
  final String? quickTips;

  @JsonKey(name: 'story_image')
  final String? storyImage;

  @JsonKey(name: 'publish_status')
  final String? publishStatus;

  @JsonKey(name: 'question_set_id')
  final int? questionSetId;

  @JsonKey(name: 'story_description')
  final String? storyDescription;

  const CoursePractice(
      {this.id,
      this.title,
      this.lessonId,
      this.quickTips,
      this.storyImage,
      this.personaId,
      this.publishStatus,
      this.questionSetId,
      this.storyDescription});

  factory CoursePractice.fromJson(Map<String, dynamic> json) =>
      _$CoursePracticeFromJson(json);

  Map<String, dynamic> toJson() => _$CoursePracticeToJson(this);
}
