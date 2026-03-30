// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCategory _$CourseCategoryFromJson(Map<String, dynamic> json) =>
    CourseCategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      isActive: json['is_active'] as bool?,
    );

Map<String, dynamic> _$CourseCategoryToJson(CourseCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'is_active': instance.isActive,
    };
