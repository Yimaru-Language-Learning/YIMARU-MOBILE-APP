// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'practice.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Practice _$PracticeFromJson(Map<String, dynamic> json) => Practice(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      status: json['status'] as String?,
      setType: json['set_type'] as String?,
      persona: json['persona'] as String?,
      ownerId: (json['owner_id'] as num?)?.toInt(),
      ownerType: json['owner_type'] as String?,
      description: json['description'] as String?,
      introVideoUrl: json['intro_video_url'] as String?,
      shuffleQuestions: json['shuffle_questions'] as bool?,
      timeLimitMinutes: (json['time_limit_minutes'] as num?)?.toInt(),
    );

Map<String, dynamic> _$PracticeToJson(Practice instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'persona': instance.persona,
      'description': instance.description,
      'owner_id': instance.ownerId,
      'set_type': instance.setType,
      'owner_type': instance.ownerType,
      'intro_video_url': instance.introVideoUrl,
      'shuffle_questions': instance.shuffleQuestions,
      'time_limit_minutes': instance.timeLimitMinutes,
    };
