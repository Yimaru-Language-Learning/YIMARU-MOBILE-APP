import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/course_module.dart';

import 'access.dart';

part 'course_unit.g.dart';

@JsonSerializable()
class CourseUnit {
  final int? id;

  final String? name;

  final Access? access;

  final String? thumbnail;

  final String? description;

  final List<CourseModule>? modules;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  @JsonKey(name: 'has_practice')
  final bool? hasPractice;

  @JsonKey(name: 'lessons_count')
  final int? lessonsCount;

  @JsonKey(name: 'modules_count')
  final int? modulesCount;

  @JsonKey(name: 'practices_count')
  final int? practice;

  @JsonKey(name: 'catalog_course_id')
  final int? catalogCourseId;

  const CourseUnit(
      {this.id,
      this.name,
      this.access,
      this.modules,
      this.practice,
      this.thumbnail,
      this.sortOrder,
      this.hasPractice,
      this.description,
      this.modulesCount,
      this.lessonsCount,
      this.catalogCourseId});

  factory CourseUnit.fromJson(Map<String, dynamic> json) =>
      _$CourseUnitFromJson(json);

  Map<String, dynamic> toJson() => _$CourseUnitToJson(this);

  CourseUnit copyWith({
    int? id,
    String? name,
    int? practice,
    int? sortOrder,
    Access? access,
    bool? hasPractice,
    int? lessonsCount,
    int? modulesCount,
    String? thumbnail,
    String? description,
    int? catalogCourseId,
    List<CourseModule>? modules,
  }) =>
      CourseUnit(
        id: id ?? this.id,
        name: name ?? this.name,
        access: access ?? this.access,
        modules: modules ?? this.modules,
        practice: practice ?? this.practice,
        thumbnail: thumbnail ?? this.thumbnail,
        sortOrder: sortOrder ?? this.sortOrder,
        hasPractice: hasPractice ?? this.hasPractice,
        description: description ?? this.description,
        lessonsCount: lessonsCount ?? this.lessonsCount,
        modulesCount: modulesCount ?? this.modulesCount,
        catalogCourseId: catalogCourseId ?? this.catalogCourseId,
      );
}
