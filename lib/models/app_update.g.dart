// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_update.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUpdate _$AppUpdateFromJson(Map<String, dynamic> json) => AppUpdate(
      forceUpdate: json['force_update'] as bool?,
      updateAvailable: json['update_available'] as bool?,
    );

Map<String, dynamic> _$AppUpdateToJson(AppUpdate instance) => <String, dynamic>{
      'force_update': instance.forceUpdate,
      'update_available': instance.updateAvailable,
    };
