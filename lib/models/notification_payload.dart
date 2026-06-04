import 'package:json_annotation/json_annotation.dart';

part 'notification_payload.g.dart';

@JsonSerializable()
class NotificationPayload {
  final String? message;

  final String? headline;

  const NotificationPayload({this.message, this.headline});

  factory NotificationPayload.fromJson(Map<String, dynamic> json) =>
      _$NotificationPayloadFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationPayloadToJson(this);
}
