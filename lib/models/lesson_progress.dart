import 'package:json_annotation/json_annotation.dart';

import 'access.dart';

part 'lesson_progress.g.dart';

@JsonSerializable()
class LessonProgress {
  final int? id;

  final String? title;

  final Access? access;

  @JsonKey(name: 'module_id')
  final int? moduleId;


  const LessonProgress(
      {this.id,this.title,this.access,this.moduleId});

  factory LessonProgress.fromJson(Map<String, dynamic> json) => _$LessonProgressFromJson(json);

  Map<String, dynamic> toJson() => _$LessonProgressToJson(this);
}
