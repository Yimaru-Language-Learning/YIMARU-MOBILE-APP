// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModule _$CourseModuleFromJson(Map<String, dynamic> json) => CourseModule(
      id: (json['id'] as num?)?.toInt(),
      icon: json['icon'] as String?,
      name: json['name'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      unitId: (json['unit_id'] as num?)?.toInt(),
      thumbnail: json['thumbnail'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      accessTier: json['access_tier'] as String?,
      hasPractice: json['has_practice'] as bool?,
      description: json['description'] as String?,
      lessonsCount: (json['lessons_count'] as num?)?.toInt(),
      practicesCount: (json['practices_count'] as num?)?.toInt(),
      effectiveAccessTier: json['effective_access_tier'] as String?,
    );

Map<String, dynamic> _$CourseModuleToJson(CourseModule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'icon': instance.icon,
      'access': instance.access,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'unit_id': instance.unitId,
      'sort_order': instance.sortOrder,
      'access_tier': instance.accessTier,
      'has_practice': instance.hasPractice,
      'lessons_count': instance.lessonsCount,
      'practices_count': instance.practicesCount,
      'effective_access_tier': instance.effectiveAccessTier,
    };
