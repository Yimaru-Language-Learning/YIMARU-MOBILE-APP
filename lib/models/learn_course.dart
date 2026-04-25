import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/access.dart';

part 'learn_course.g.dart';

@JsonSerializable()
class LearnCourse {
  final int? id;

  final String? name;

  final Access? access;

  final String? description;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  @JsonKey(name: 'program_id')
  final int? programId;

  const LearnCourse(
      {this.id,
      this.name,
      this.access,
      this.programId,
      this.sortOrder,
      this.description});

  factory LearnCourse.fromJson(Map<String, dynamic> json) =>
      _$LearnCourseFromJson(json);

  Map<String, dynamic> toJson() => _$LearnCourseToJson(this);
}
