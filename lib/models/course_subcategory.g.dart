// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_subcategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseSubcategory _$CourseSubcategoryFromJson(Map<String, dynamic> json) =>
    CourseSubcategory(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      isActive: json['is_active'] as bool?,
      thumbnail: json['thumbnail'] as String?,
      categoryId: (json['category_id'] as num?)?.toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$CourseSubcategoryToJson(CourseSubcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'is_active': instance.isActive,
      'category_id': instance.categoryId,
    };
