import 'package:json_annotation/json_annotation.dart';

part 'refresh_object.g.dart';

@JsonSerializable()
class RefreshObject {
  final String? url;

  @JsonKey(name: 'object_key')
  final String? objectKey;

  const RefreshObject({this.url, this.objectKey});

  factory RefreshObject.fromJson(Map<String, dynamic> json) =>
      _$RefreshObjectFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshObjectToJson(this);
}
