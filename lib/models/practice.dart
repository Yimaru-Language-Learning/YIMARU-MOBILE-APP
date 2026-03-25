import 'package:json_annotation/json_annotation.dart';
part 'practice.g.dart';

@JsonSerializable()
class Practice {
  final int? id;

  final String? title;

  final String? status;

  final String? persona;

  final String? description;

  @JsonKey(name: 'owner_id')
  final int? ownerId;

  @JsonKey(name: 'set_type')
  final String? setType;

  @JsonKey(name: 'owner_type')
  final String? ownerType;

  @JsonKey(name: 'shuffle_questions')
  final bool? shuffleQuestions;



  const Practice({
    this.id,
    this.title,this.status,this.setType,this.persona,this.ownerId,this.ownerType,this.description,this.shuffleQuestions
  });

  factory Practice.fromJson(Map<String, dynamic> json) =>
      _$PracticeFromJson(json);

  Map<String, dynamic> toJson() => _$PracticeToJson(this);
}
