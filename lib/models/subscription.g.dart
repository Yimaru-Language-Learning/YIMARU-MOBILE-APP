// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Subscription _$SubscriptionFromJson(Map<String, dynamic> json) => Subscription(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      isActive: json['is_active'] as bool?,
      currency: json['currency'] as String?,
      description: json['description'] as String?,
      durationUnit: json['duration_unit'] as String?,
      durationValue: (json['duration_value'] as num?)?.toInt(),
    );

Map<String, dynamic> _$SubscriptionToJson(Subscription instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'currency': instance.currency,
      'description': instance.description,
      'is_active': instance.isActive,
      'duration_unit': instance.durationUnit,
      'duration_value': instance.durationValue,
    };
