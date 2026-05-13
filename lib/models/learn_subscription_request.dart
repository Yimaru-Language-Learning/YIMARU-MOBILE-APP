import 'package:json_annotation/json_annotation.dart';

part 'learn_subscription_request.g.dart';

@JsonSerializable()
class LearnSubscriptionRequest {
  final double? amount;

  final String? currency;

  @JsonKey(name: 'payment_id')
  final int? paymentId;

  @JsonKey(name: 'session_id')
  final String? sessionId;

  @JsonKey(name: 'payment_url')
  final String? paymentUrl;

  const LearnSubscriptionRequest(
      {this.amount,
      this.currency,
      this.sessionId,
      this.paymentId,
      this.paymentUrl});

  factory LearnSubscriptionRequest.fromJson(Map<String, dynamic> json) =>
      _$LearnSubscriptionRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LearnSubscriptionRequestToJson(this);
}
