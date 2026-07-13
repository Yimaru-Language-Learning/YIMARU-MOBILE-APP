import 'package:json_annotation/json_annotation.dart';

import 'access.dart';

part 'course_lesson.g.dart';

@JsonSerializable()
class CourseLesson {
  final int? id;

  final String? title;

  final Access? access;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'video_url')
  final String? videoUrl;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  @JsonKey(name: 'has_practice')
  final bool? hasPractice;

  @JsonKey(name: 'unit_module_id')
  final int? unitModuleId;

  const CourseLesson(
      {this.id,
      this.title,
      this.access,
      this.videoUrl,
      this.sortOrder,
      this.thumbnail,
      this.description,
      this.hasPractice,
      this.unitModuleId});

  factory CourseLesson.fromJson(Map<String, dynamic> json) =>
      _$CourseLessonFromJson(json);

  Map<String, dynamic> toJson() => _$CourseLessonToJson(this);
}
