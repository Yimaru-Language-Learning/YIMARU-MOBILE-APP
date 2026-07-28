import 'package:json_annotation/json_annotation.dart';

import 'access.dart';

part 'course_catalog.g.dart';

@JsonSerializable()
class CourseCatalog {
  final int? id;

  final String? name;

  final Access? access;

  final String? category;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  @JsonKey(name: 'units_count')
  final int? unitsCount;

  @JsonKey(name: 'has_practice')
  final bool? hasPractice;

  @JsonKey(name: 'modules_count')
  final int? modulesCount;

  @JsonKey(name: 'lessons_count')
  final int? lessonsCount;

  const CourseCatalog({
    this.id,
    this.name,
    this.access,
    this.category,
    this.thumbnail,
    this.sortOrder,
    this.unitsCount,
    this.hasPractice,
    this.description,
    this.modulesCount,
    this.lessonsCount,
  });

  CourseCatalog copyWith({
    int? id,
    String? name,
    Access? access,
    int? sortOrder,
    int? unitsCount,
    String? category,
    int? modulesCount,
    int? lessonsCount,
    bool? hasPractice,
    String? thumbnail,
    String? description,
  }) =>
      CourseCatalog(
        id: id ?? this.id,
        name: name ?? this.name,
        access: access ?? this.access,
        category: category ?? this.category,
        thumbnail: thumbnail ?? this.thumbnail,
        sortOrder: sortOrder ?? this.sortOrder,
        unitsCount: unitsCount ?? this.unitsCount,
        hasPractice: hasPractice ?? this.hasPractice,
        description: description ?? this.description,
        modulesCount: modulesCount ?? this.modulesCount,
        lessonsCount: lessonsCount ?? this.lessonsCount,
      );

  factory CourseCatalog.fromJson(Map<String, dynamic> json) =>
      _$CourseCatalogFromJson(json);

  Map<String, dynamic> toJson() => _$CourseCatalogToJson(this);
}
