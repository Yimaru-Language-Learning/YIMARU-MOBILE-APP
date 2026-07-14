import 'package:json_annotation/json_annotation.dart';

part 'active_subscription.g.dart';

@JsonSerializable()
class ActiveSubscription {
  final int? id;

  final double? price;

  final String? status;

  final String? currency;

  final String? category;

  @JsonKey(name: 'plan_id')
  final int? planId;

  @JsonKey(name: 'starts_at')
  final String? startsAt;

  @JsonKey(name: 'plan_name')
  final String? planName;

  @JsonKey(name: 'auto_renew')
  final bool? autoRenew;

  @JsonKey(name: 'expires_at')
  final String? expiresAt;

  @JsonKey(name: 'duration_unit')
  final String? durationUnit;

  @JsonKey(name: 'duration_value')
  final int? durationValue;

  const ActiveSubscription(
      {this.id,
      this.price,
      this.status,
      this.planId,
      this.startsAt,
      this.planName,
      this.category,
      this.currency,
      this.autoRenew,
      this.expiresAt,
      this.durationUnit,
      this.durationValue});

  factory ActiveSubscription.fromJson(Map<String, dynamic> json) => _$ActiveSubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$ActiveSubscriptionToJson(this);
}
