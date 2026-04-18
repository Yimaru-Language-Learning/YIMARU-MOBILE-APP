import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';

@JsonSerializable()
class Category {
  final int? id;

  final String? name;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'total_count')
  final int? totalCount;

  const Category({this.id, this.name, this.isActive, this.totalCount});

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}
