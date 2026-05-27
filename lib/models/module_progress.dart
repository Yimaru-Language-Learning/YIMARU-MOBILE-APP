import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/lesson_progress.dart';

import 'access.dart';

part 'module_progress.g.dart';

@JsonSerializable()
class ModuleProgress {
  final int? id;

  final String? name;

  final Access? access;

  final List<LessonProgress>? lessons;

  @JsonKey(name: 'course_id')
  final int? courseId;

  @JsonKey(name: 'program_id')
  final int? programId;

  const ModuleProgress(
      {this.id,
      this.name,
      this.access,
      this.lessons,
      this.courseId,
      this.programId});

  factory ModuleProgress.fromJson(Map<String, dynamic> json) =>
      _$ModuleProgressFromJson(json);

  Map<String, dynamic> toJson() => _$ModuleProgressToJson(this);
}
