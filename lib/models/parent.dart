import 'package:json_annotation/json_annotation.dart';

part 'parent.g.dart';

@JsonSerializable()
class Parent {
  @JsonKey(name: 'parent_id')
  final int? parentId;

  @JsonKey(name: 'parent_kind')
  final String? parentKind;

  const Parent({this.parentId, this.parentKind});

  factory Parent.fromJson(Map<String, dynamic> json) => _$ParentFromJson(json);

  Map<String, dynamic> toJson() => _$ParentToJson(this);
}
