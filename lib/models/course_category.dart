import 'package:json_annotation/json_annotation.dart';

part 'course_category.g.dart';

@JsonSerializable()
class CourseCategory {
  final int? id;

  final String? name;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  const CourseCategory({this.id, this.name, this.isActive});

  factory CourseCategory.fromJson(Map<String, dynamic> json) =>
      _$CourseCategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCategoryToJson(this);
}
