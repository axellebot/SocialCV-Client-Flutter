import 'dart:async';

import 'package:cv/src/models/skill_group.dart';

abstract class IDataRepository {
  Future<List<SkillGroup>> getSkillGroups();
}
