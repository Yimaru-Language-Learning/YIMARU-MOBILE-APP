import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/access.dart';

part 'learn_program.g.dart';

@JsonSerializable()
class LearnProgram {
  final int? id;

  final String? name;

  final Access? access;

  final String? description;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  const LearnProgram(
      {this.id, this.name, this.access, this.sortOrder, this.description});

  factory LearnProgram.fromJson(Map<String, dynamic> json) =>
      _$LearnProgramFromJson(json);

  Map<String, dynamic> toJson() => _$LearnProgramToJson(this);
}
