import 'package:json_annotation/json_annotation.dart';

part 'field_option.g.dart';

@JsonSerializable()
class FieldOption {
  final String? code;

  final String? label;

  const FieldOption({this.code, this.label});

  factory FieldOption.fromJson(Map<String, dynamic> json) =>
      _$FieldOptionFromJson(json);

  Map<String, dynamic> toJson() => _$FieldOptionToJson(this);
}
