import 'package:json_annotation/json_annotation.dart';

part 'level.g.dart';

@JsonSerializable()
class Level {
  final int? id;

  final String? title;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'cefr_level')
  final String? cerfLevel;

  @JsonKey(name: 'total_count')
  final int? totalCount;

  @JsonKey(name: 'display_order')
  final int? displayOrder;

  const Level({
    this.id,
    this.title,
    this.isActive,
    this.cerfLevel,
    this.thumbnail,
    this.totalCount,
    this.description,
    this.displayOrder,
  });

  factory Level.fromJson(Map<String, dynamic> json) => _$LevelFromJson(json);

  Map<String, dynamic> toJson() => _$LevelToJson(this);
}
