// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_detail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetail _$CourseDetailFromJson(Map<String, dynamic> json) => CourseDetail(
      course: json['course'] == null
          ? null
          : Course.fromJson(json['course'] as Map<String, dynamic>),
      courseProgress: json['courseProgress'] == null
          ? null
          : CourseProgress.fromJson(
              json['courseProgress'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CourseDetailToJson(CourseDetail instance) =>
    <String, dynamic>{
      'course': instance.course,
      'courseProgress': instance.courseProgress,
    };
