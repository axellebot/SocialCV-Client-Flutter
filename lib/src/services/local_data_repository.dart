import 'dart:async' show Future;
import 'dart:convert';

import 'package:cv/src/models/skill_group.dart';
import 'package:cv/src/services/data_repository.dart';
import 'package:flutter/services.dart';

class LocalDataRepository implements IDataRepository {
  Map<String, dynamic> jsonCV;

  LocalDataRepository() {
    jsonCV = null;
  }

  Future loadCV({force: false}) async {
    if (!force && jsonCV != null) return Future.value(null);
    return rootBundle.loadString('images/data/cv.json').then((value) {
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
