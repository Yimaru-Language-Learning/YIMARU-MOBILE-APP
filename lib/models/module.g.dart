// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'module.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Module _$ModuleFromJson(Map<String, dynamic> json) => Module(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      iconUrl: json['icon_url'] as String?,
      levelId: (json['level_id'] as num?)?.toInt(),
      isActive: json['is_active'] as bool?,
      description: json['description'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ModuleToJson(Module instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'icon_url': instance.iconUrl,
      'level_id': instance.levelId,
      'is_active': instance.isActive,
      'display_order': instance.displayOrder,
    };
