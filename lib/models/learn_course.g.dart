// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnCourse _$LearnCourseFromJson(Map<String, dynamic> json) => LearnCourse(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      effectiveAccessTier: json['effective_access_tier'] as String?,
      programId: (json['program_id'] as num?)?.toInt(),
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$LearnCourseToJson(LearnCourse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'access': instance.access,
      'effective_access_tier': instance.effectiveAccessTier,
      'description': instance.description,
      'sort_order': instance.sortOrder,
      'program_id': instance.programId,
    };
