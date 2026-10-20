// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnLesson _$LearnLessonFromJson(Map<String, dynamic> json) => LearnLesson(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      effectiveAccessTier: json['effective_access_tier'] as String?,
      videoUrl: json['video_url'] as String?,
      moduleId: (json['module_id'] as num?)?.toInt(),
      thumbnail: json['thumbnail'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      description: json['description'] as String?,
      hasPractice: json['has_practice'] as bool?,
    );

Map<String, dynamic> _$LearnLessonToJson(LearnLesson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'access': instance.access,
      'effective_access_tier': instance.effectiveAccessTier,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'has_practice': instance.hasPractice,
      'module_id': instance.moduleId,
      'sort_order': instance.sortOrder,
      'video_url': instance.videoUrl,
    };
