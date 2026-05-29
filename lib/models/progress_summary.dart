import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/course_progress.dart';

import 'access.dart';

part 'progress_summary.g.dart';

@JsonSerializable()
class ProgressSummary {
  final int? id;

  final String? name;

  final Access? access;

  final List<CourseProgress>? courses;

  const ProgressSummary({this.id, this.name, this.access, this.courses});

  factory ProgressSummary.fromJson(Map<String, dynamic> json) =>
      _$ProgressSummaryFromJson(json);

  Map<String, dynamic> toJson() => _$ProgressSummaryToJson(this);
}
