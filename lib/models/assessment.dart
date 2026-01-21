import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/option.dart';
import 'package:yimaru_app/models/question.dart';
part 'assessment.g.dart';

@JsonSerializable()
class Assessment {
  @JsonKey(name: 'Question')
  final Question? question;

  @JsonKey(name: 'Options')
  final List<Option>? options;

  const Assessment({this.options, this.question});

  factory Assessment.fromJson(Map<String, dynamic> json) =>
      _$AssessmentFromJson(json);

  Map<String, dynamic> toJson() => _$AssessmentToJson(this);
}
