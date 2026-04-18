// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subcategory.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subcategory _$SubcategoryFromJson(Map<String, dynamic> json) => Subcategory(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      isActive: json['is_active'] as bool?,
      totalCount: (json['total_count'] as num?)?.toInt(),
      categoryId: (json['category_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      categoryName: json['category_name'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubcategoryToJson(Subcategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'is_active': instance.isActive,
      'total_count': instance.totalCount,
      'category_id': instance.categoryId,
      'category_name': instance.categoryName,
      'display_order': instance.displayOrder,
    };
