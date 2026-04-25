import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/access.dart';

part 'learn_module.g.dart';

@JsonSerializable()
class LearnModule {
  final int? id;

  final String? icon;

  final String? name;

  final Access? access;

  final String? description;

  @JsonKey(name: 'program_id')
  final int? programId;

  @JsonKey(name: 'course_id')
  final int? courseId;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  const LearnModule(
      {this.id,
      this.icon,
      this.name,
      this.access,
      this.courseId,
      this.sortOrder,
      this.programId,
      this.description});

  factory LearnModule.fromJson(Map<String, dynamic> json) =>
      _$LearnModuleFromJson(json);

  Map<String, dynamic> toJson() => _$LearnModuleToJson(this);
}
