// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseLesson _$CourseLessonFromJson(Map<String, dynamic> json) => CourseLesson(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      status: json['status'] as String?,
      courseId: (json['sub_course_id'] as num?)?.toInt(),
      videoUrl: json['video_url'] as String?,
      duration: (json['duration'] as num?)?.toInt(),
      thumbnail: json['thumbnail'] as String?,
      visibility: json['visibility'] as String?,
      resolution: json['resolution'] as String?,
      vimeoStatus: json['vimeo_status'] as String?,
      description: json['description'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
      instructorId: (json['instructor_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseLessonToJson(CourseLesson instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'duration': instance.duration,
      'status': instance.status,
      'thumbnail': instance.thumbnail,
      'resolution': instance.resolution,
      'visibility': instance.visibility,
      'description': instance.description,
      'video_url': instance.videoUrl,
      'vimeo_status': instance.vimeoStatus,
      'instructor_id': instance.instructorId,
      'sub_course_id': instance.courseId,
      'display_order': instance.displayOrder,
    };
