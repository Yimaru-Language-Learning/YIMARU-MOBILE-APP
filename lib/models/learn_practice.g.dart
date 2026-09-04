// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learn_practice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearnPractice _$LearnPracticeFromJson(Map<String, dynamic> json) =>
    LearnPractice(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      parents: (json['parents'] as List<dynamic>?)
          ?.map((e) => Parent.fromJson(e as Map<String, dynamic>))
          .toList(),
      parentId: (json['parent_id'] as num?)?.toInt(),
      quickTips: json['quick_tips'] as String?,
      storyImage: json['story_image'] as String?,
      parentKind: json['parent_kind'] as String?,
      questionSetId: (json['question_set_id'] as num?)?.toInt(),
      storyDescription: json['story_description'] as String?,
    );

Map<String, dynamic> _$LearnPracticeToJson(LearnPractice instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'parent_id': instance.parentId,
      'quick_tips': instance.quickTips,
      'parents': instance.parents,
      'story_image': instance.storyImage,
      'parent_kind': instance.parentKind,
      'question_set_id': instance.questionSetId,
      'story_description': instance.storyDescription,
    };
