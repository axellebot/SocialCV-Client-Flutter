import 'dart:convert';

import 'package:cv/models/skill_group.dart';
import 'package:cv/services/data_repository.dart';
import 'package:flutter/services.dart';
import 'dart:async' show Future;

class LocalDataRepository implements IDataRepository {
  Map<String, dynamic> jsonCV;

  LocalDataRepository() {
    jsonCV = null;
  }

  Future loadCV({force: false}) async {
    if (!force && jsonCV != null) return Future.value(null);
    return rootBundle.loadString('assets/data/cv.json').then((value) {
      jsonCV = json.decode(value);
    });
  }

  @override
  Future<List<SkillGroup>> getSkillGroups() async {
    await loadCV();
    List<SkillGroup> skillGroups = [];

    List<dynamic> skillGroupsMap = jsonCV["skillGroups"];
    skillGroupsMap.forEach((skillGroupMap) {
      skillGroups.add(SkillGroup.fromJson(skillGroupMap));
    });
    return Future.value(skillGroups);
  }
}
