import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
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

  @JsonKey(name: 'subscription_status')
  final String? subscriptionStatus;

  @JsonKey(name: 'profile_picture_url')
  final String? profilePicture;

  const User(
      {this.email,
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
      this.subscriptionStatus});

  User copyWith(
          {int? userId,
          String? email,
          String? gender,
          String? region,
          String? country,
          String? lastName,
          String? birthday,
          String? firstName,
          String? occupation,
          String? accessToken,
          String? refreshToken,
          bool? userInfoLoaded,
          bool? profileCompleted,
          String? profilePicture,
          String? subscriptionStatus}) =>
      User(
          email: email ?? this.email,
          userId: userId ?? this.userId,
          gender: gender ?? this.gender,
          region: region ?? this.region,
          country: country ?? this.country,
          lastName: lastName ?? this.lastName,
          birthday: birthday ?? this.birthday,
          firstName: firstName ?? this.firstName,
          occupation: occupation ?? this.occupation,
          accessToken: accessToken ?? this.accessToken,
          refreshToken: refreshToken ?? this.refreshToken,
          userInfoLoaded: userInfoLoaded ?? this.userInfoLoaded,
          profilePicture: profilePicture ?? this.profilePicture,
          profileCompleted: profileCompleted ?? this.profileCompleted,
          subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
