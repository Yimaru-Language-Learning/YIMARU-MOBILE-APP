import 'package:json_annotation/json_annotation.dart';

import 'access.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final int? id;

  final String? title;

  final Access? access;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'access_tier')
  final String? accessTier;

  @JsonKey(name: 'category_id')
  final int? categoryId;

  @JsonKey(name: 'total_count')
  final int? totalCount;

  @JsonKey(name: 'has_practice')
  final bool? hasPractice;

  @JsonKey(name: 'lessons_count')
  final int? lessonsCount;

  @JsonKey(name: 'practices_count')
  final String? practicesCount;

  @JsonKey(name: 'intro_video_url')
  final String? introVideoUrl;

  @JsonKey(name: 'sub_category_id')
  final int? subCategoryId;

  @JsonKey(name: 'effective_access_tier')
  final String? effectiveAccessTier;

  const Course(
      {this.id,
      this.title,
      this.access,
      this.isActive,
      this.thumbnail,
      this.accessTier,
      this.totalCount,
      this.categoryId,
      this.description,
      this.hasPractice,
      this.lessonsCount,
      this.introVideoUrl,
      this.subCategoryId,
      this.practicesCount,
      this.effectiveAccessTier});

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
