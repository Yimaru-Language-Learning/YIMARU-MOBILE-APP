// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_subscription_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnSubscriptionRequest _$LearnSubscriptionRequestFromJson(
        Map<String, dynamic> json) =>
    LearnSubscriptionRequest(
      amount: (json['amount'] as num?)?.toDouble(),
      currency: json['currency'] as String?,
      sessionId: json['session_id'] as String?,
      paymentId: (json['payment_id'] as num?)?.toInt(),
      paymentUrl: json['payment_url'] as String?,
    );

Map<String, dynamic> _$LearnSubscriptionRequestToJson(
        LearnSubscriptionRequest instance) =>
    <String, dynamic>{
      'amount': instance.amount,
      'currency': instance.currency,
      'payment_id': instance.paymentId,
      'session_id': instance.sessionId,
      'payment_url': instance.paymentUrl,
    };
