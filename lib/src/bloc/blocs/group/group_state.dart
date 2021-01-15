import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class GroupState extends Equatable {
  GroupState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class GroupUninitialized extends GroupState
    with ElementUninitialized<GroupEntity> {}

class GroupLoading extends GroupState with ElementLoading<GroupEntity> {}

class GroupLoaded extends GroupState with ElementLoaded<GroupEntity> {
  GroupLoaded({GroupEntity group}) : super([group]) {
    element = group;
  }

  @override
  String toString() {
    return '$runtimeType{ '
        'group: $element'
        ' }';
  }
}

class GroupFailure extends GroupState with ElementFailure<GroupEntity> {
  GroupFailure({@required dynamic error})
      : assert(error != null, 'No error given'),
        super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType { '
      'error: $error'
      ' }';
}
