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

  @JsonKey(name: 'access_tier')
  final String? accessTier;

  @JsonKey(name: 'has_practice')
  final bool? hasPractice;

  @JsonKey(name: 'lessons_count')
  final int? lessonsCount;

  @JsonKey(name: 'practices_count')
  final int? practicesCount;

  @JsonKey(name: 'effective_access_tier')
  final String? effectiveAccessTier;

  const CourseModule(
      {this.id,
      this.icon,
      this.name,
      this.access,
      this.unitId,
      this.thumbnail,
      this.sortOrder,
      this.accessTier,
      this.hasPractice,
      this.description,
      this.lessonsCount,
      this.practicesCount,
      this.effectiveAccessTier});

  CourseModule copyWith({
    int? id,
    int? unitId,
    String? name,
    String? icon,
    int? practice,
    Access? access,
    int? sortOrder,
    bool? hasPractice,
    int? lessonsCount,
    String? thumbnail,
    String? accessTier,
    String? description,
    int? practicesCount,
    String? effectiveAccessTier,
  }) =>
      CourseModule(
          id: id ?? this.id,
          name: name ?? this.name,
          icon: icon ?? this.icon,
          access: access ?? this.access,
          unitId: unitId ?? this.unitId,
          sortOrder: sortOrder ?? this.sortOrder,
          thumbnail: thumbnail ?? this.thumbnail,
          accessTier: accessTier ?? this.accessTier,
          hasPractice: hasPractice ?? this.hasPractice,
          description: description ?? this.description,
          lessonsCount: lessonsCount ?? this.lessonsCount,
          practicesCount: practice ?? this.practicesCount,
          effectiveAccessTier: effectiveAccessTier ?? this.effectiveAccessTier);

  factory CourseModule.fromJson(Map<String, dynamic> json) =>
      _$CourseModuleFromJson(json);

  Map<String, dynamic> toJson() => _$CourseModuleToJson(this);
}
