import 'package:json_annotation/json_annotation.dart';

part 'course_subcategory.g.dart';

@JsonSerializable()
class CourseSubcategory {
  final int? id;

  final String? title;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'category_id')
  final int? categoryId;

  const CourseSubcategory(
      {this.id,
      this.title,
      this.isActive,
      this.thumbnail,
      this.categoryId,
      this.description});

  factory CourseSubcategory.fromJson(Map<String, dynamic> json) =>
      _$CourseSubcategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CourseSubcategoryToJson(this);
}
