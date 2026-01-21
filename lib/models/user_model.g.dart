// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: (json['user_id'] as num?)?.toInt(),
      accessToken: json['access_token'] as String?,
      profileCompleted: json['profileCompleted'] as bool?,
      refreshToken: json['refresh_token'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'user_id': instance.userId,
      'profileCompleted': instance.profileCompleted,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
