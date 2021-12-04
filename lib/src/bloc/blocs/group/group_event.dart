import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// [GroupEvent] that must be dispatch to [GroupBloc]

abstract class GroupEvent extends Equatable {
  const GroupEvent() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class GroupInitialize extends GroupEvent with ElementInitialize<GroupEntity> {
  GroupInitialize({String? groupId, GroupEntity? group})
      : assert(
          groupId != null && group == null,
          '$GroupInitialize must be created with a $GroupEntity or its ID',
        ),
        assert(
          groupId == null && group != null,
          '$GroupInitialize must be created with a $GroupEntity or its ID',
        ),
        super() {
    elementId = groupId;
    element = group;
  }

  @override
  List<Object?> get props => super.props..addAll([elementId, element]);

  @override
  String toString() => '$runtimeType{ id: $elementId, element: $element }';
}

class GroupRefresh extends GroupEvent with ElementRefresh<GroupEntity> {}
