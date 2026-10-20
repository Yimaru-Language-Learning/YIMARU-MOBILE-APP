import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/access.dart';

part 'learn_course.g.dart';

@JsonSerializable()
class LearnCourse {
  final int? id;

  final String? name;

  final Access? access;

  @JsonKey(name: 'effective_access_tier')
  final String? effectiveAccessTier;

  final String? description;

  @JsonKey(name: 'sort_order')
  final int? sortOrder;

  @JsonKey(name: 'program_id')
  final int? programId;

  const LearnCourse({
    this.id,
    this.name,
    this.access,
    this.effectiveAccessTier,
    this.programId,
    this.sortOrder,
    this.description,
  });

  LearnCourse copyWith({
    int? id,
    String? name,
    Access? access,
    String? effectiveAccessTier,
    int? sortOrder,
    int? programId,
    String? description,
  }) {
    return LearnCourse(
      id: id ?? this.id,
      name: name ?? this.name,
      access: access ?? this.access,
      effectiveAccessTier: effectiveAccessTier ?? this.effectiveAccessTier,
      sortOrder: sortOrder ?? this.sortOrder,
      programId: programId ?? this.programId,
      description: description ?? this.description,
    );
  }

  factory LearnCourse.fromJson(Map<String, dynamic> json) =>
      _$LearnCourseFromJson(json);

  Map<String, dynamic> toJson() => _$LearnCourseToJson(this);
}
