import 'package:json_annotation/json_annotation.dart';

import 'access.dart';

part 'course_catalog.g.dart';

@JsonSerializable()
class CourseCatalog {
  final int? id;

  final String? name;

  final Access? access;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  @JsonKey(name: 'units_count')
  final int? unitsCount;

  @JsonKey(name: 'modules_count')
  final int? modulesCount;

  @JsonKey(name: 'lessons_count')
  final int? lessonsCount;

  @JsonKey(name: 'has_practice')
  final bool? hasPractice;

  const CourseCatalog({
    this.id,
    this.name,
    this.access,
    this.thumbnail,
    this.sortOrder,
    this.unitsCount,
    this.hasPractice,
    this.description,
    this.modulesCount,
    this.lessonsCount,
  });

  factory CourseCatalog.fromJson(Map<String, dynamic> json) =>
      _$CourseCatalogFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCatalogToJson(this);
}
