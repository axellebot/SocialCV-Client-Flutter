import 'dart:async';
import 'package:cv/models/skill_group.dart';

abstract class IDataRepository {
  Future<List<SkillGroup>> getSkillGroups();
}