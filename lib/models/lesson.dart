import 'package:json_annotation/json_annotation.dart';

part 'lesson.g.dart';

@JsonSerializable()
class Lesson {
  final int? id;

  final String? title;

  final String? thumbnail;

  final String? description;

  @JsonKey(name: 'is_active')
  final bool? isActive;

  @JsonKey(name: 'sub_module_id')
  final int? subModuleId;

  @JsonKey(name: 'teaching_text')
  final String? teachingText;

  @JsonKey(name: 'display_order')
  final int? displayOrder;

  @JsonKey(name: 'teaching_video_url')
  final String? teachingVideoUrl;

  @JsonKey(name: 'teaching_image_url')
  final String? teachingImageUrl;

  @JsonKey(name: 'teaching_audio_url')
  final String? teachingAudioUrl;

  const Lesson(
      {this.id,
      this.title,
      this.isActive,
      this.thumbnail,
      this.subModuleId,
      this.description,
      this.teachingText,
      this.displayOrder,
      this.teachingAudioUrl,
      this.teachingImageUrl,
      this.teachingVideoUrl});

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  Map<String, dynamic> toJson() => _$LessonToJson(this);
}
