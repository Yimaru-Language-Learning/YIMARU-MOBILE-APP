import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? email;

  final String? gender;

  final String? region;

  final String? country;

  final String? occupation;

  final bool? userInfoLoaded;

  @JsonKey(name: 'user_id')
  final int? userId;

  @JsonKey(name: 'last_name')
  final String? lastName;

  @JsonKey(name: 'birth_day')
  final String? birthday;

  @JsonKey(name: 'first_name')
  final String? firstName;

  @JsonKey(name: 'access_token')
  final String? accessToken;

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  @JsonKey(name: 'profile_completed')
  final bool? profileCompleted;

  @JsonKey(name: 'profile_picture_url')
  final String? profilePicture;

  const UserModel({
    this.email,
    this.region,
    this.gender,
    this.userId,
    this.country,
    this.lastName,
    this.birthday,
    this.firstName,
    this.occupation,
    this.accessToken,
    this.refreshToken,
    this.profilePicture,
    this.userInfoLoaded,
    this.profileCompleted,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
