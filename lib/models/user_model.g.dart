// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      userId: (json['user_id'] as num?)?.toInt(),
      firstName: json['firstName'] as String?,
      accessToken: json['access_token'] as String?,
      profileImage: json['profileImage'] as String?,
      refreshToken: json['refresh_token'] as String?,
      profileCompleted: json['profileCompleted'] as bool?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'firstName': instance.firstName,
      'user_id': instance.userId,
      'profileImage': instance.profileImage,
      'profileCompleted': instance.profileCompleted,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
    };
