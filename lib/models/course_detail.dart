import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/course_progress.dart';
import 'package:yimaru_app/models/course.dart';

part 'course_detail.g.dart';

@JsonSerializable()
class CourseDetail {
  final Course? course;

  final CourseProgress? courseProgress;

  const CourseDetail({this.course, this.courseProgress});

  factory CourseDetail.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailFromJson(json);

  Map<String, dynamic> toJson() => _$CourseDetailToJson(this);
}
