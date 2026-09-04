// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_practice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursePractice _$CoursePracticeFromJson(Map<String, dynamic> json) =>
    CoursePractice(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      parents: (json['parents'] as List<dynamic>?)
          ?.map((e) => Parent.fromJson(e as Map<String, dynamic>))
          .toList(),
      lessonId: (json['lesson_id'] as num?)?.toInt(),
      quickTips: json['quick_tips'] as String?,
      storyImage: json['story_image'] as String?,
      personaId: (json['persona_id'] as num?)?.toInt(),
      publishStatus: json['publish_status'] as String?,
      questionSetId: (json['question_set_id'] as num?)?.toInt(),
      storyDescription: json['story_description'] as String?,
    );

Map<String, dynamic> _$CoursePracticeToJson(CoursePractice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'lesson_id': instance.lessonId,
      'parents': instance.parents,
      'persona_id': instance.personaId,
      'quick_tips': instance.quickTips,
      'story_image': instance.storyImage,
      'publish_status': instance.publishStatus,
      'question_set_id': instance.questionSetId,
      'story_description': instance.storyDescription,
    };
