// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssessmentSession _$AssessmentSessionFromJson(Map<String, dynamic> json) =>
    AssessmentSession(
      completed: json['completed'] as bool?,
      nextLevel: json['next_level'] as String?,
      publishedLevels: (json['published_levels'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      initialAssessmentCompleted: json['initial_assessment_completed'] as bool?,
    );

Map<String, dynamic> _$AssessmentSessionToJson(AssessmentSession instance) =>
    <String, dynamic>{
      'completed': instance.completed,
      'next_level': instance.nextLevel,
      'published_levels': instance.publishedLevels,
      'initial_assessment_completed': instance.initialAssessmentCompleted,
    };
