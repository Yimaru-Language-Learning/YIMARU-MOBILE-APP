// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Level _$LevelFromJson(Map<String, dynamic> json) => Level(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      isActive: json['is_active'] as bool?,
      cerfLevel: json['cefr_level'] as String?,
      thumbnail: json['thumbnail'] as String?,
      totalCount: (json['total_count'] as num?)?.toInt(),
      description: json['description'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'is_active': instance.isActive,
      'cefr_level': instance.cerfLevel,
      'total_count': instance.totalCount,
      'display_order': instance.displayOrder,
    };
