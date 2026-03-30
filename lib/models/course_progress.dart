import 'package:json_annotation/json_annotation.dart';

part 'course_progress.g.dart';

@JsonSerializable()
class CourseProgress {
  final String? level;

  final String? title;

  final String? description;

  @JsonKey(name: 'is_locked')
  final bool? isLocked;

  @JsonKey(name: 'sub_course_id')
  final int? courseId;

  @JsonKey(name: 'display_order')
  final int? displayOrder;

  @JsonKey(name: 'progress_status')
  final String? progressStatus;

  @JsonKey(name: 'progress_percentage')
  final double? progressPercentage;

  const CourseProgress(
      {this.level,
      this.title,
      this.isLocked,
      this.courseId,
      this.description,
      this.displayOrder,
      this.progressStatus,
      this.progressPercentage});

  factory CourseProgress.fromJson(Map<String, dynamic> json) =>
      _$CourseProgressFromJson(json);

  Map<String, dynamic> toJson() => _$CourseProgressToJson(this);
}
