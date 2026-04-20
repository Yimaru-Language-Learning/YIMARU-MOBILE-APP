// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Lesson _$LessonFromJson(Map<String, dynamic> json) => Lesson(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      isActive: json['is_active'] as bool?,
      thumbnail: json['thumbnail'] as String?,
      subModuleId: (json['sub_module_id'] as num?)?.toInt(),
      description: json['description'] as String?,
      teachingText: json['teaching_text'] as String?,
      displayOrder: (json['display_order'] as num?)?.toInt(),
      teachingAudioUrl: json['teaching_audio_url'] as String?,
      teachingImageUrl: json['teaching_image_url'] as String?,
      teachingVideoUrl: json['teaching_video_url'] as String?,
    );

Map<String, dynamic> _$LessonToJson(Lesson instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'thumbnail': instance.thumbnail,
      'description': instance.description,
      'is_active': instance.isActive,
      'sub_module_id': instance.subModuleId,
      'teaching_text': instance.teachingText,
      'display_order': instance.displayOrder,
      'teaching_video_url': instance.teachingVideoUrl,
      'teaching_image_url': instance.teachingImageUrl,
      'teaching_audio_url': instance.teachingAudioUrl,
    };
