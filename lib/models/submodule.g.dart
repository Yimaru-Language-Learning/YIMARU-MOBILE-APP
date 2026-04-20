// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'submodule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Submodule _$SubmoduleFromJson(Map<String, dynamic> json) => Submodule(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      tips: json['tips'] as String?,
      moduleId: (json['module_id'] as num?)?.toInt(),
      isActive: json['is_active'] as bool?,
      thumbnail: json['thumbnail'] as String?,
      description: json['description'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
      legacySubCourseId: (json['legacy_sub_course_id'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubmoduleToJson(Submodule instance) => <String, dynamic>{
      'id': instance.id,
      'tips': instance.tips,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'module_id': instance.moduleId,
      'is_active': instance.isActive,
      'display_order': instance.displayOrder,
      'legacy_sub_course_id': instance.legacySubCourseId,
    };
