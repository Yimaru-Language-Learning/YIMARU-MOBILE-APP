// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseProgress _$CourseProgressFromJson(Map<String, dynamic> json) =>
    CourseProgress(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => ModuleProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      programId: (json['program_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseProgressToJson(CourseProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'access': instance.access,
      'modules': instance.modules,
      'program_id': instance.programId,
    };
