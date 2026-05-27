// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ModuleProgress _$ModuleProgressFromJson(Map<String, dynamic> json) =>
    ModuleProgress(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      lessons: (json['lessons'] as List<dynamic>?)
          ?.map((e) => LessonProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
      courseId: (json['course_id'] as num?)?.toInt(),
      programId: (json['program_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ModuleProgressToJson(ModuleProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'access': instance.access,
      'lessons': instance.lessons,
      'course_id': instance.courseId,
      'program_id': instance.programId,
    };
