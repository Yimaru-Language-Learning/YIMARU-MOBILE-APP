import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/notification_payload.dart';

part 'in_app_notification.g.dart';

@JsonSerializable()
class InAppNotification {
  final String? id;

  final String? type;

  final String? level;

  final String? image;

  final NotificationPayload? payload;

  @JsonKey(name: 'is_read')
  final bool? isRead;

  @JsonKey(name: 'reciever')
  final String? receiver;

  @JsonKey(name: 'recipient_id')
  final int? recipientId;

  @JsonKey(name: 'receiver_type')
  final String? receiverType;

  @JsonKey(name: 'error_severity')
  final String? errorSeverity;

  @JsonKey(name: 'delivery_status')
  final String? deliveryStatus;

  @JsonKey(name: 'delivery_channel')
  final String? deliveryChannel;

  const InAppNotification(
      {this.id,
      this.type,
      this.image,
      this.level,
      this.isRead,
      this.payload,
      this.receiver,
      this.recipientId,
      this.receiverType,
      this.errorSeverity,
      this.deliveryStatus,
      this.deliveryChannel});

  factory InAppNotification.fromJson(Map<String, dynamic> json) =>
      _$InAppNotificationFromJson(json);

  Map<String, dynamic> toJson() => _$InAppNotificationToJson(this);
}
