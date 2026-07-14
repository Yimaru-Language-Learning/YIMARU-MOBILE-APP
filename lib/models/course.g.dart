// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Course _$CourseFromJson(Map<String, dynamic> json) => Course(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      isActive: json['is_active'] as bool?,
      thumbnail: json['thumbnail'] as String?,
      totalCount: (json['total_count'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      hasPractice: json['has_practice'] as bool?,
      introVideoUrl: json['intro_video_url'] as String?,
      subCategoryId: (json['sub_category_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseToJson(Course instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'access': instance.access,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'is_active': instance.isActive,
      'category_id': instance.categoryId,
      'total_count': instance.totalCount,
      'has_practice': instance.hasPractice,
      'intro_video_url': instance.introVideoUrl,
      'sub_category_id': instance.subCategoryId,
    };
