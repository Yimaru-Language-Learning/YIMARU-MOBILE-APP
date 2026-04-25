// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnProgram _$LearnProgramFromJson(Map<String, dynamic> json) => LearnProgram(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      sortOrder: (json['sort_order'] as num?)?.toInt(),
      description: json['description'] as String?,
    );

Map<String, dynamic> _$LearnProgramToJson(LearnProgram instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'access': instance.access,
      'description': instance.description,
      'sort_order': instance.sortOrder,
    };
