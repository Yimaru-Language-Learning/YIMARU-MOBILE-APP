// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ActiveSubscription _$ActiveSubscriptionFromJson(Map<String, dynamic> json) =>
    ActiveSubscription(
      id: (json['id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      status: json['status'] as String?,
      planId: (json['plan_id'] as num?)?.toInt(),
      startsAt: json['starts_at'] as String?,
      planName: json['plan_name'] as String?,
      category: json['category'] as String?,
      currency: json['currency'] as String?,
      autoRenew: json['auto_renew'] as bool?,
      expiresAt: json['expires_at'] as String?,
      durationUnit: json['duration_unit'] as String?,
      durationValue: (json['duration_value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$ActiveSubscriptionToJson(ActiveSubscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'status': instance.status,
      'currency': instance.currency,
      'category': instance.category,
      'plan_id': instance.planId,
      'starts_at': instance.startsAt,
      'plan_name': instance.planName,
      'auto_renew': instance.autoRenew,
      'expires_at': instance.expiresAt,
      'duration_unit': instance.durationUnit,
      'duration_value': instance.durationValue,
    };
