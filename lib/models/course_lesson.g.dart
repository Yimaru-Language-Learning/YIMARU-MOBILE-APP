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
      accessTier: json['access_tier'] as String?,
      description: json['description'] as String?,
      hasPractice: json['has_practice'] as bool?,
      unitModuleId: (json['unit_module_id'] as num?)?.toInt(),
      lessonsCount: (json['lessons_count'] as num?)?.toInt(),
      practicesCount: (json['practices_count'] as num?)?.toInt(),
      effectiveAccessTier: json['effective_access_tier'] as String?,
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
      'access_tier': instance.accessTier,
      'has_practice': instance.hasPractice,
      'lessons_count': instance.lessonsCount,
      'unit_module_id': instance.unitModuleId,
      'practices_count': instance.practicesCount,
      'effective_access_tier': instance.effectiveAccessTier,
    };
