import 'package:json_annotation/json_annotation.dart';

part 'my_subscription.g.dart';

@JsonSerializable()
class MySubscription {
  final int? id;

  final String? status;

  final double? price;

  final String? currency;

  final String? category;

  @JsonKey(name: 'plan_id')
  final int? planId;

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'starts_at')
  final String? startsAt;

  @JsonKey(name: 'plan_name')
  final String? planName;

  @JsonKey(name: 'created_at')
  final String? createdAt;

  @JsonKey(name: 'auto_renew')
  final bool? autoRenew;

  @JsonKey(name: 'expires_at')
  final String? expiresAt;

  @JsonKey(name: 'is_lifetime')
  final bool? isLifetime;

  @JsonKey(name: 'duration_unit')
  final String? durationUnit;

  @JsonKey(name: 'duration_value')
  final int? durationValue;

  @JsonKey(name: 'payment_method')
  final String? paymentMethod;
  @JsonKey(name: 'payment_reference')
  final String? paymentReference;

  const MySubscription({
    this.id,
    this.price,
    this.status,
    this.userId,
    this.planId,
    this.planName,
    this.currency,
    this.category,
    this.startsAt,
    this.expiresAt,
    this.autoRenew,
    this.createdAt,
    this.isLifetime,
    this.durationUnit,
    this.durationValue,
    this.paymentMethod,
    this.paymentReference,
  });

  factory MySubscription.fromJson(Map<String, dynamic> json) =>
      _$MySubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$MySubscriptionToJson(this);
}
