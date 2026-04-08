import 'package:json_annotation/json_annotation.dart';

part 'course_lesson.g.dart';

@JsonSerializable()
class CourseLesson {
  int? id;

  String? title;

  int? duration;

  String? status;

  String? thumbnail;

  String? resolution;

  String? visibility;

  String? description;

  @JsonKey(name: 'video_url')
  String? videoUrl;

  @JsonKey(name: 'vimeo_status')
  String? vimeoStatus;

  @JsonKey(name: 'instructor_id')
  int? instructorId;

  @JsonKey(name: 'sub_course_id')
  int? courseId;

  @JsonKey(name: 'display_order')
  int? displayOrder;

  CourseLesson(
      {this.id,
      this.title,
      this.status,
      this.courseId,
      this.videoUrl,
      this.duration,
      this.thumbnail,
      this.visibility,
      this.resolution,
      this.vimeoStatus,
      this.description,
      this.displayOrder,
      this.instructorId});

  factory CourseLesson.fromJson(Map<String, dynamic> json) =>
      _$CourseLessonFromJson(json);

  Map<String, dynamic> toJson() => _$CourseLessonToJson(this);
}
