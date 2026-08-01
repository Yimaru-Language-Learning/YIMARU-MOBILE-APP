import 'package:json_annotation/json_annotation.dart';

part 'faq.g.dart';

@JsonSerializable()
class Faq {
  final int? id;

  final String? answer;

  final String? status;

  final String? question;

  final String? category;

  @JsonKey(name: 'display_order')
  final int? displayOrder;

  const Faq(
      {this.id,
      this.answer,
      this.status,
      this.category,
      this.question,
      this.displayOrder});

  factory Faq.fromJson(Map<String, dynamic> json) => _$FaqFromJson(json);

  Map<String, dynamic> toJson() => _$FaqToJson(this);
}
