// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assessment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Assessment _$AssessmentFromJson(Map<String, dynamic> json) => Assessment(
      id: (json['id'] as num?)?.toInt(),
      title: json['title'] as String?,
      status: json['status'] as String?,
      setType: json['set_type'] as String?,
      description: json['description'] as String?,
      passingScore: (json['passing_score'] as num?)?.toInt(),
      shuffleQuestions: json['shuffle_questions'] as bool?,
    );

Map<String, dynamic> _$AssessmentToJson(Assessment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'description': instance.description,
      'set_type': instance.setType,
      'passing_score': instance.passingScore,
      'shuffle_questions': instance.shuffleQuestions,
    };
