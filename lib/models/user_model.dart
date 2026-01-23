import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String? firstName;

  @JsonKey(name: 'user_id')
  final int? userId;

  final String? profileImage;

  final bool? profileCompleted;

  @JsonKey(name: 'access_token')
  final String? accessToken;

  @JsonKey(name: 'refresh_token')
  final String? refreshToken;

  const UserModel({
    this.userId,
    this.firstName,
    this.accessToken,
    this.profileImage,
    this.refreshToken,
    this.profileCompleted,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
