import 'package:json_annotation/json_annotation.dart';

part 'learn_subscription.g.dart';

@JsonSerializable()
class LearnSubscription {
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

  const LearnSubscription(
      {this.id,
      this.name,
      this.price,
      this.isActive,
      this.currency,
      this.description,
      this.durationUnit,
      this.durationValue});

  factory LearnSubscription.fromJson(Map<String, dynamic> json) =>
      _$LearnSubscriptionFromJson(json);

  Map<String, dynamic> toJson() => _$LearnSubscriptionToJson(this);
}
