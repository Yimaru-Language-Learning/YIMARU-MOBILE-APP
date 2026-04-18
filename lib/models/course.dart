import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final int? id;

  final String? title;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'category_id')
  final int? categoryId;

  @JsonKey(name: 'total_count')
  final int? totalCount;

  @JsonKey(name: 'intro_video_url')
  final String? introVideoUrl;

  @JsonKey(name: 'sub_category_id')
  final int? subCategoryId;

  const Course({
    this.id,
    this.title,
    this.isActive,
    this.thumbnail,
    this.totalCount,
    this.categoryId,
    this.description,
    this.introVideoUrl,
    this.subCategoryId,
  });

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
