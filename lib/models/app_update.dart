import 'package:json_annotation/json_annotation.dart';

part 'app_update.g.dart';

@JsonSerializable()
class AppUpdate {
  @JsonKey(name: 'force_update')
  final bool? forceUpdate;

  @JsonKey(name: 'update_available')
  final bool? updateAvailable;

  const AppUpdate({this.forceUpdate, this.updateAvailable});

  factory AppUpdate.fromJson(Map<String, dynamic> json) =>
      _$AppUpdateFromJson(json);

  Map<String, dynamic> toJson() => _$AppUpdateToJson(this);
}
