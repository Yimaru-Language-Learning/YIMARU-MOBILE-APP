import 'package:json_annotation/json_annotation.dart';

import 'access.dart';

part 'learn_lesson.g.dart';

@JsonSerializable()
class LearnLesson {
  final int? id;

  final String? title;

  final Access? access;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'module_id')
  final int? moduleId;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  @JsonKey(name: 'video_url')
  final String? videoUrl;

  const LearnLesson({
    this.id,
    this.title,
    this.access,
    this.videoUrl,
    this.moduleId,
    this.thumbnail,
    this.sortOrder,
    this.description,
  });

  factory LearnLesson.fromJson(Map<String, dynamic> json) =>
      _$LearnLessonFromJson(json);

  Map<String, dynamic> toJson() => _$LearnLessonToJson(this);
}
