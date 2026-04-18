import 'package:json_annotation/json_annotation.dart';

part 'subcategory.g.dart';

@JsonSerializable()
class Subcategory {
  final int? id;

  final String? name;

  final String? description;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'total_count')
  final int? totalCount;

  @JsonKey(name: 'category_id')
  final int? categoryId;

  @JsonKey(name: 'category_name')
  final String? categoryName;

  @JsonKey(name: 'display_order')
  final int? displayOrder;

  const Subcategory(
      {this.id,
      this.name,
      this.isActive,
      this.totalCount,
      this.categoryId,
      this.description,
      this.categoryName,
      this.displayOrder});

  factory Subcategory.fromJson(Map<String, dynamic> json) =>
      _$SubcategoryFromJson(json);

  Map<String, dynamic> toJson() => _$SubcategoryToJson(this);
}
