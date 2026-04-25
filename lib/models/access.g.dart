// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Access _$AccessFromJson(Map<String, dynamic> json) => Access(
      reason: json['reason'] as String?,
      totalCount: (json['total_count'] as num?)?.toInt(),
      isCompleted: json['is_completed'] as bool?,
      isAccessible: json['is_accessible'] as bool?,
      completedCount: (json['completed_count'] as num?)?.toInt(),
      progressPercent: (json['progress_percent'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AccessToJson(Access instance) => <String, dynamic>{
      'reason': instance.reason,
      'total_count': instance.totalCount,
      'is_completed': instance.isCompleted,
      'is_accessible': instance.isAccessible,
      'completed_count': instance.completedCount,
      'progress_percent': instance.progressPercent,
    };
