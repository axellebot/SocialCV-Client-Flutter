library skill;

import 'package:json_annotation/json_annotation.dart';

part 'skill_group.g.dart';

@JsonSerializable()
class SkillGroup {
  SkillGroup(this.label, this.skills);

  String label;
  List<String> skills;

  factory SkillGroup.fromJson(Map<String, dynamic> json) =>
      _$SkillGroupFromJson(json);
}
