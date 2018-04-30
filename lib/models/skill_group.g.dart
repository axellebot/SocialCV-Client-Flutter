// GENERATED CODE - DO NOT MODIFY BY HAND

part of skill;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

SkillGroup _$SkillGroupFromJson(Map<String, dynamic> json) => new SkillGroup(
    json['label'] as String,
    (json['skills'] as List)?.map((e) => e as String)?.toList());

abstract class _$SkillGroupSerializerMixin {
  String get label;
  List<String> get skills;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'label': label, 'skills': skills};
}
