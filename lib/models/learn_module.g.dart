// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnModule _$LearnModuleFromJson(Map<String, dynamic> json) => LearnModule(
      id: (json['id'] as num?)?.toInt(),
      icon: json['icon'] as String?,
      name: json['name'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      courseId: (json['course_id'] as num?)?.toInt(),
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      programId: (json['program_id'] as num?)?.toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$LearnModuleToJson(LearnModule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'icon': instance.icon,
      'name': instance.name,
      'access': instance.access,
      'description': instance.description,
      'program_id': instance.programId,
      'course_id': instance.courseId,
      'sort_order': instance.sortOrder,
    };
