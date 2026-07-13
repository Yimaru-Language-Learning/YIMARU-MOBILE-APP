// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseLesson _$CourseLessonFromJson(Map<String, dynamic> json) => CourseLesson(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      videoUrl: json['video_url'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      thumbnail: json['thumbnail'] as String?,
      description: json['description'] as String?,
      hasPractice: json['has_practice'] as bool?,
      unitModuleId: (json['unit_module_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseLessonToJson(CourseLesson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'access': instance.access,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'video_url': instance.videoUrl,
      'sort_order': instance.sortOrder,
      'has_practice': instance.hasPractice,
      'unit_module_id': instance.unitModuleId,
    };
