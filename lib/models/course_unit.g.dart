// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_unit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseUnit _$CourseUnitFromJson(Map<String, dynamic> json) => CourseUnit(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      modules: (json['modules'] as List<dynamic>?)
          ?.map((e) => CourseModule.fromJson(e as Map<String, dynamic>))
          .toList(),
      practice: (json['practices_count'] as num?)?.toInt(),
      thumbnail: json['thumbnail'] as String?,
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      hasPractice: json['has_practice'] as bool?,
      description: json['description'] as String?,
      modulesCount: (json['modules_count'] as num?)?.toInt(),
      lessonsCount: (json['lessons_count'] as num?)?.toInt(),
      catalogCourseId: (json['catalog_course_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$CourseUnitToJson(CourseUnit instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'modules': instance.modules,
      'sort_order': instance.sortOrder,
      'has_practice': instance.hasPractice,
      'lessons_count': instance.lessonsCount,
      'modules_count': instance.modulesCount,
      'practices_count': instance.practice,
      'catalog_course_id': instance.catalogCourseId,
    };
