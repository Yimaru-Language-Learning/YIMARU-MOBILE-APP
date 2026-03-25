// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: (json['id'] as num?)?.toInt(),
      level: json['level'] as String?,
      title: json['title'] as String?,
      isActive: json['is_active'] as bool?,
      courseId: (json['course_id'] as num?)?.toInt(),
      thumbnail: json['thumbnail'] as String?,
      description: json['description'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'level': instance.level,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'course_id': instance.courseId,
      'is_active': instance.isActive,
      'display_order': instance.displayOrder,
    };
