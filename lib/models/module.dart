import 'package:json_annotation/json_annotation.dart';

part 'module.g.dart';

@JsonSerializable()
class Module {
  final int? id;

  final String? title;

  final String? description;

  @JsonKey(name: 'icon_url')
  final String? iconUrl;

  @JsonKey(name: 'level_id')
  final int? levelId;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'display_order')
  final int? displayOrder;

  const Module({
    this.id,
    this.title,
    this.iconUrl,
    this.levelId,
    this.isActive,
    this.description,
    this.displayOrder,
  });

  factory Module.fromJson(Map<String, dynamic> json) => _$ModuleFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleToJson(this);
}
