import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/active_subscription.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final bool? learn;

  final bool? ielts;

  final String? email;

  final bool? duolingo;

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

  @JsonKey(name: 'phone_number')
  final String? phoneNumber;

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  @JsonKey(name: 'profile_completed')
  final bool? profileCompleted;

  @JsonKey(name: 'subscription_status')
  final String? subscriptionStatus;

  @JsonKey(name: 'profile_picture_url')
  final String? profilePicture;

  @JsonKey(name: 'active_subscriptions')
  final List<ActiveSubscription>? activeSubscriptions;

  const User(
      {this.learn,
      this.ielts,
      this.email,
      this.region,
      this.gender,
      this.userId,
      this.country,
      this.lastName,
      this.birthday,
      this.duolingo,
      this.firstName,
      this.occupation,
      this.accessToken,
      this.phoneNumber,
      this.refreshToken,
      this.profilePicture,
      this.userInfoLoaded,
      this.profileCompleted,
      this.subscriptionStatus,
      this.activeSubscriptions});

  User copyWith(
          {bool? learn,
          bool? ielts,
          int? userId,
          String? email,
          String? gender,
          String? region,
          String? country,
          bool? duolingo,
          String? lastName,
          String? birthday,
          String? firstName,
          String? occupation,
          String? accessToken,
          String? phoneNumber,
          String? refreshToken,
          bool? userInfoLoaded,
          bool? profileCompleted,
          String? profilePicture,
          String? subscriptionStatus,
          List<ActiveSubscription>? activeSubscriptions}) =>
      User(
          ielts: ielts ?? this.ielts,
          learn: learn ?? this.learn,
          email: email ?? this.email,
          userId: userId ?? this.userId,
          gender: gender ?? this.gender,
          region: region ?? this.region,
          country: country ?? this.country,
          duolingo: duolingo ?? this.duolingo,
          lastName: lastName ?? this.lastName,
          birthday: birthday ?? this.birthday,
          firstName: firstName ?? this.firstName,
          occupation: occupation ?? this.occupation,
          accessToken: accessToken ?? this.accessToken,
          phoneNumber: phoneNumber ?? this.phoneNumber,
          refreshToken: refreshToken ?? this.refreshToken,
          userInfoLoaded: userInfoLoaded ?? this.userInfoLoaded,
          profilePicture: profilePicture ?? this.profilePicture,
          profileCompleted: profileCompleted ?? this.profileCompleted,
          subscriptionStatus: subscriptionStatus ?? this.subscriptionStatus,
          activeSubscriptions: activeSubscriptions ?? this.activeSubscriptions);

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
