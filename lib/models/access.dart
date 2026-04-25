import 'package:json_annotation/json_annotation.dart';

part 'access.g.dart';

@JsonSerializable()
class Access {
  final String? reason;

  @JsonKey(name: 'total_count')
  final int? totalCount;

  @JsonKey(name: 'is_completed')
  final bool? isCompleted;

  @JsonKey(name: 'is_accessible')
  final bool? isAccessible;

  @JsonKey(name: 'completed_count')
  final int? completedCount;

  @JsonKey(name: 'progress_percent')
  final int? progressPercent;

  const Access(
      {this.reason,
      this.totalCount,
      this.isCompleted,
      this.isAccessible,
      this.completedCount,
      this.progressPercent});

  factory Access.fromJson(Map<String, dynamic> json) => _$AccessFromJson(json);

  Map<String, dynamic> toJson() => _$AccessToJson(this);
}
