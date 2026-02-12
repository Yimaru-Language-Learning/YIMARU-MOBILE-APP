// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      email: json['email'] as String?,
      region: json['region'] as String?,
      gender: json['gender'] as String?,
      userId: (json['user_id'] as num?)?.toInt(),
      country: json['country'] as String?,
      lastName: json['last_name'] as String?,
      birthday: json['birth_day'] as String?,
      firstName: json['first_name'] as String?,
      occupation: json['occupation'] as String?,
      accessToken: json['access_token'] as String?,
      refreshToken: json['refresh_token'] as String?,
      profilePicture: json['profile_picture_url'] as String?,
      profileCompleted: json['profile_completed'] as bool?,
      userInfoLoaded: json['userInfoLoaded'] as bool? ?? false,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'email': instance.email,
      'gender': instance.gender,
      'region': instance.region,
      'country': instance.country,
      'occupation': instance.occupation,
      'userInfoLoaded': instance.userInfoLoaded,
      'user_id': instance.userId,
      'last_name': instance.lastName,
      'birth_day': instance.birthday,
      'first_name': instance.firstName,
      'access_token': instance.accessToken,
      'refresh_token': instance.refreshToken,
      'profile_completed': instance.profileCompleted,
      'profile_picture_url': instance.profilePicture,
    };
