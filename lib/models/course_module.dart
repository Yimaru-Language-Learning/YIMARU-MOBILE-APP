import 'package:json_annotation/json_annotation.dart';

import 'access.dart';

part 'course_module.g.dart';

@JsonSerializable()
class CourseModule {
  final int? id;

  final String? name;

  final String? icon;

  final Access? access;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'unit_id')
  final int? unitId;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  @JsonKey(name: 'has_practice')
  final bool? hasPractice;

  @JsonKey(name: 'lessons_count')
  final int? lessonsCount;

  @JsonKey(name: 'practices_count')
  final int? practice;

  const CourseModule(
      {this.id,
      this.icon,
      this.name,
      this.access,
      this.unitId,
      this.practice,
      this.thumbnail,
      this.sortOrder,
      this.hasPractice,
      this.description,
      this.lessonsCount});

  factory CourseModule.fromJson(Map<String, dynamic> json) =>
      _$CourseModuleFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModuleToJson(this);
}
