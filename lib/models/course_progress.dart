import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/module_progress.dart';

import 'access.dart';

part 'course_progress.g.dart';

@JsonSerializable()
class CourseProgress {
  final int? id;

  final String? name;

  final Access? access;

  final List<ModuleProgress>? modules;


  @JsonKey(name: 'program_id')
  final int? programId;



  const CourseProgress(
      {this.id,this.name,this.access,this.modules,this.programId});

  factory CourseProgress.fromJson(Map<String, dynamic> json) => _$CourseProgressFromJson(json);

  Map<String, dynamic> toJson() => _$CourseProgressToJson(this);
}
