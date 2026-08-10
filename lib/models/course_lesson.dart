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

  @JsonKey(name: 'access_tier')
  final String? accessTier;

  @JsonKey(name: 'has_practice')
  final bool? hasPractice;

  @JsonKey(name: 'lessons_count')
  final int? lessonsCount;

  @JsonKey(name: 'unit_module_id')
  final int? unitModuleId;

  @JsonKey(name: 'practices_count')
  final int? practicesCount;

  @JsonKey(name: 'effective_access_tier')
  final String? effectiveAccessTier;

  const CourseLesson(
      {this.id,
      this.title,
      this.access,
      this.videoUrl,
      this.sortOrder,
      this.thumbnail,
      this.accessTier,
      this.description,
      this.hasPractice,
      this.unitModuleId,
      this.lessonsCount,
      this.practicesCount,
      this.effectiveAccessTier});

  CourseLesson copyWith({
    int? id,
    String? title,
    Access? access,
    int? sortOrder,
    String? videoUrl,
    bool? hasPractice,
    int? unitModuleId,
    String? thumbnail,
    int? lessonsCount,
    String? accessTier,
    String? description,
    int? practicesCount,
    String? effectiveAccessTier,
  }) =>
      CourseLesson(
          id: id ?? this.id,
          title: title ?? this.title,
          access: access ?? this.access,
          videoUrl: videoUrl ?? this.videoUrl,
          sortOrder: sortOrder ?? this.sortOrder,
          thumbnail: thumbnail ?? this.thumbnail,
          accessTier: accessTier ?? this.accessTier,
          hasPractice: hasPractice ?? this.hasPractice,
          description: description ?? this.description,
          unitModuleId: unitModuleId ?? this.unitModuleId,
          lessonsCount: lessonsCount ?? this.lessonsCount,
          practicesCount: practicesCount ?? this.practicesCount,
          effectiveAccessTier: effectiveAccessTier ?? this.effectiveAccessTier);

  factory CourseLesson.fromJson(Map<String, dynamic> json) =>
      _$CourseLessonFromJson(json);

  Map<String, dynamic> toJson() => _$CourseLessonToJson(this);
}
