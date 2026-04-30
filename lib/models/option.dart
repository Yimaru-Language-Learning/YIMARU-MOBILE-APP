import 'package:json_annotation/json_annotation.dart';
part 'option.g.dart';

@JsonSerializable()
class Option {
  final int? id;

  @JsonKey(name: 'is_correct')
  final bool? isCorrect;

  @JsonKey(name: 'option_text')
  final String? optionText;

  @JsonKey(name: 'option_order')
  final int? optionOrder;

  const Option({this.id, this.optionText, this.isCorrect, this.optionOrder});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
