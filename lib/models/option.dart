import 'package:json_annotation/json_annotation.dart';
part 'option.g.dart';

@JsonSerializable()
class Option {
  @JsonKey(name: 'question_id')
  final int? questionId;

  @JsonKey(name: 'option_text')
  final String? optionText;

  const Option({this.optionText, this.questionId});

  factory Option.fromJson(Map<String, dynamic> json) => _$OptionFromJson(json);

  Map<String, dynamic> toJson() => _$OptionToJson(this);
}
