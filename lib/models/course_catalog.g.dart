// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_catalog.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCatalog _$CourseCatalogFromJson(Map<String, dynamic> json) =>
    CourseCatalog(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      category: json['category'] as String?,
      thumbnail: json['thumbnail'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      unitsCount: (json['units_count'] as num?)?.toInt(),
      hasPractice: json['has_practice'] as bool?,
      description: json['description'] as String?,
      modulesCount: (json['modules_count'] as num?)?.toInt(),
      lessonsCount: (json['lessons_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseCatalogToJson(CourseCatalog instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'access': instance.access,
      'category': instance.category,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'sort_order': instance.sortOrder,
      'units_count': instance.unitsCount,
      'has_practice': instance.hasPractice,
      'modules_count': instance.modulesCount,
      'lessons_count': instance.lessonsCount,
    };
