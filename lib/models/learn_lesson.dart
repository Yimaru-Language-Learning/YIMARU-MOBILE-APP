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

  @JsonKey(name: 'has_practice')
  final bool? hasPractice;

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
    this.hasPractice,
  });

  LearnLesson copyWith({
    int? id,
    String? title,
    int? moduleId,
    int? sortOrder,
    Access? access,
    String? videoUrl,
    String? thumbnail,
    String? description,
    bool? hasPractice,
  }) {
    return LearnLesson(
      id: id ?? this.id,
      title: title ?? this.title,
      access: access ?? this.access,
      videoUrl: videoUrl ?? this.videoUrl,
      moduleId: moduleId ?? this.moduleId,
      sortOrder: sortOrder ?? this.sortOrder,
      thumbnail: thumbnail ?? this.thumbnail,
      description: description ?? this.description,
      hasPractice: hasPractice ?? this.hasPractice,
    );
  }

  factory LearnLesson.fromJson(Map<String, dynamic> json) =>
      _$LearnLessonFromJson(json);

  Map<String, dynamic> toJson() => _$LearnLessonToJson(this);
}
