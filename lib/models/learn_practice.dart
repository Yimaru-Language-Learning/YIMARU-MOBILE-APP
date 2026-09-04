import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/parent.dart';

part 'learn_practice.g.dart';

@JsonSerializable()
class LearnPractice {
  final int? id;

  final String? title;

  @JsonKey(name: 'parent_id')
  final int? parentId;

  @JsonKey(name: 'quick_tips')
  final String? quickTips;

  final List<Parent>? parents;

  @JsonKey(name: 'story_image')
  final String? storyImage;

  @JsonKey(name: 'parent_kind')
  final String? parentKind;

  @JsonKey(name: 'question_set_id')
  final int? questionSetId;

  @JsonKey(name: 'story_description')
  final String? storyDescription;

  const LearnPractice(
      {this.id,
      this.title,
      this.parents,
      this.parentId,
      this.quickTips,
      this.storyImage,
      this.parentKind,
      this.questionSetId,
      this.storyDescription});

  factory LearnPractice.fromJson(Map<String, dynamic> json) =>
      _$LearnPracticeFromJson(json);

  Map<String, dynamic> toJson() => _$LearnPracticeToJson(this);
}
