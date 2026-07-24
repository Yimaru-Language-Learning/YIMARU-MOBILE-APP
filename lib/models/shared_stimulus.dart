import 'package:json_annotation/json_annotation.dart';
import 'package:yimaru_app/models/dynamic_payload.dart';

import 'dynamic_item.dart';

part 'shared_stimulus.g.dart';

@JsonSerializable()
class SharedStimulus {
  final List<DynamicItem>? stimulus;

  const SharedStimulus({this.stimulus});

  factory SharedStimulus.fromJson(Map<String, dynamic> json) =>
      _$SharedStimulusFromJson(json);

  Map<String, dynamic> toJson() => _$SharedStimulusToJson(this);
}
