// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProgressSummary _$ProgressSummaryFromJson(Map<String, dynamic> json) =>
    ProgressSummary(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      access: json['access'] == null
          ? null
          : Access.fromJson(json['access'] as Map<String, dynamic>),
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => CourseProgress.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ProgressSummaryToJson(ProgressSummary instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'access': instance.access,
      'courses': instance.courses,
    };
