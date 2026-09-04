// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parent.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Parent _$ParentFromJson(Map<String, dynamic> json) => Parent(
      parentId: (json['parent_id'] as num?)?.toInt(),
      parentKind: json['parent_kind'] as String?,
    );

Map<String, dynamic> _$ParentToJson(Parent instance) => <String, dynamic>{
      'parent_id': instance.parentId,
      'parent_kind': instance.parentKind,
    };
