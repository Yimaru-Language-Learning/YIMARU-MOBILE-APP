import 'package:json_annotation/json_annotation.dart';

part 'subscription.g.dart';

@JsonSerializable()
class Subscription {
  final int? id;

  final String? name;

  final double? price;

  final String? currency;

  final String? description;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'duration_unit')
  final String? durationUnit;

  @JsonKey(name: 'duration_value')
  final int? durationValue;

  const Subscription(
      {this.id,
      this.name,
      this.price,
      this.isActive,
      this.currency,
      this.description,
      this.durationUnit,
      this.durationValue});

  factory Subscription.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$SubscriptionToJson(this);
}
