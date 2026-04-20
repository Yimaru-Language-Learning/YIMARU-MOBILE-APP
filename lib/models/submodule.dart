import 'package:json_annotation/json_annotation.dart';

part 'submodule.g.dart';

@JsonSerializable()
class Submodule {
  final int? id;

  final String? tips;

  final String? title;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'module_id')
  final int? moduleId;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'display_order')
  final int? displayOrder;

  @JsonKey(name: 'legacy_sub_course_id')
  final int? legacySubCourseId;

  const Submodule(
      {this.id,
      this.title,
      this.tips,
      this.moduleId,
      this.isActive,
      this.thumbnail,
      this.description,
      this.displayOrder,
      this.legacySubCourseId});

  factory Submodule.fromJson(Map<String, dynamic> json) =>
      _$SubmoduleFromJson(json);

  Map<String, dynamic> toJson() => _$SubmoduleToJson(this);
}
