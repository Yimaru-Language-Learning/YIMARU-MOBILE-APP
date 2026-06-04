// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_app_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InAppNotification _$InAppNotificationFromJson(Map<String, dynamic> json) =>
    InAppNotification(
      id: json['id'] as String?,
      type: json['type'] as String?,
      image: json['image'] as String?,
      level: json['level'] as String?,
      isRead: json['is_read'] as bool?,
      payload: json['payload'] == null
          ? null
          : NotificationPayload.fromJson(
              json['payload'] as Map<String, dynamic>),
      receiver: json['reciever'] as String?,
      recipientId: (json['recipient_id'] as num?)?.toInt(),
      receiverType: json['receiver_type'] as String?,
      errorSeverity: json['error_severity'] as String?,
      deliveryStatus: json['delivery_status'] as String?,
      deliveryChannel: json['delivery_channel'] as String?,
    );

Map<String, dynamic> _$InAppNotificationToJson(InAppNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': instance.type,
      'level': instance.level,
      'image': instance.image,
      'payload': instance.payload,
      'is_read': instance.isRead,
      'reciever': instance.receiver,
      'recipient_id': instance.recipientId,
      'receiver_type': instance.receiverType,
      'error_severity': instance.errorSeverity,
      'delivery_status': instance.deliveryStatus,
      'delivery_channel': instance.deliveryChannel,
    };
