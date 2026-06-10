import 'package:json_annotation/json_annotation.dart';

part 'dynamic_item.g.dart';

@JsonSerializable()
class DynamicItem {
  final String id;
  final String kind;
  final dynamic value;

  DynamicItem({
    required this.id,
    required this.kind,
    required this.value,
  });

  factory DynamicItem.fromJson(Map<String, dynamic> json) =>
      _$DynamicItemFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicItemToJson(this);
}
