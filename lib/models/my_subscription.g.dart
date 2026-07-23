// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MySubscription _$MySubscriptionFromJson(Map<String, dynamic> json) =>
    MySubscription(
      id: (json['id'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      status: json['status'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      planId: (json['plan_id'] as num?)?.toInt(),
      planName: json['plan_name'] as String?,
      currency: json['currency'] as String?,
      category: json['category'] as String?,
      startsAt: json['starts_at'] as String?,
      expiresAt: json['expires_at'] as String?,
      autoRenew: json['auto_renew'] as bool?,
      createdAt: json['created_at'] as String?,
      isLifetime: json['is_lifetime'] as bool?,
      durationUnit: json['duration_unit'] as String?,
      durationValue: (json['duration_value'] as num?)?.toInt(),
      paymentMethod: json['payment_method'] as String?,
      paymentReference: json['payment_reference'] as String?,
    );

Map<String, dynamic> _$MySubscriptionToJson(MySubscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'price': instance.price,
      'currency': instance.currency,
      'category': instance.category,
      'plan_id': instance.planId,
      'user_id': instance.userId,
      'starts_at': instance.startsAt,
      'plan_name': instance.planName,
      'created_at': instance.createdAt,
      'auto_renew': instance.autoRenew,
      'expires_at': instance.expiresAt,
      'is_lifetime': instance.isLifetime,
      'duration_unit': instance.durationUnit,
      'duration_value': instance.durationValue,
      'payment_method': instance.paymentMethod,
      'payment_reference': instance.paymentReference,
    };
