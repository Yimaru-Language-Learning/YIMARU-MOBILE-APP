import 'package:json_annotation/json_annotation.dart';

part 'course.g.dart';

@JsonSerializable()
class Course {
  final int? id;

  final String? level;

  final String? title;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'course_id')
  final int? courseId;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'display_order')
  final int? displayOrder;

  const Course(
      {this.id,
      this.level,
      this.title,
      this.isActive,
      this.courseId,
      this.thumbnail,
      this.description,
      this.displayOrder});

  factory Course.fromJson(Map<String, dynamic> json) => _$CourseFromJson(json);

  Map<String, dynamic> toJson() => _$CourseToJson(this);
}
