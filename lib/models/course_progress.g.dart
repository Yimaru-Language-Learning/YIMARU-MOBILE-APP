// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_progress.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseProgress _$CourseProgressFromJson(Map<String, dynamic> json) =>
    CourseProgress(
      level: json['level'] as String?,
      title: json['title'] as String?,
      isLocked: json['is_locked'] as bool?,
      courseId: (json['sub_course_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
      progressStatus: json['progress_status'] as String?,
      progressPercentage: (json['progress_percentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$CourseProgressToJson(CourseProgress instance) =>
    <String, dynamic>{
      'level': instance.level,
      'title': instance.title,
      'description': instance.description,
      'is_locked': instance.isLocked,
      'sub_course_id': instance.courseId,
      'display_order': instance.displayOrder,
      'progress_status': instance.progressStatus,
      'progress_percentage': instance.progressPercentage,
    };
