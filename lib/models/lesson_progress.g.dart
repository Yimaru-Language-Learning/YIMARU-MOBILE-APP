// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonProgress _$LessonProgressFromJson(Map<String, dynamic> json) =>
    LessonProgress(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      moduleId: (json['module_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LessonProgressToJson(LessonProgress instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'access': instance.access,
      'module_id': instance.moduleId,
    };
