import 'package:json_annotation/json_annotation.dart';

import 'dynamic_item.dart';

part 'dynamic_payload.g.dart';

@JsonSerializable()
class DynamicPayload {
  final List<DynamicItem>? stimulus;

  final List<DynamicItem>? response;

  const DynamicPayload({this.stimulus, this.response});

  factory DynamicPayload.fromJson(Map<String, dynamic> json) =>
      _$DynamicPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$DynamicPayloadToJson(this);
}
