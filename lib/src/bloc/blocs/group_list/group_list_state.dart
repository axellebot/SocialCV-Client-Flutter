import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class GroupListState extends Equatable {
  GroupListState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class GroupListUninitialized extends GroupListState
    with ElementListUninitialized<GroupEntity> {}

class GroupListLoading extends GroupListState
    with ElementListLoading<GroupEntity> {
  GroupListLoading({int count = 0}) : super([count]) {
    this.count = count;
  }

  @override
  String toString() => '$runtimeType{ '
      'count: $count'
      ' }';
}

class GroupListLoaded extends GroupListState
    with ElementListLoaded<GroupEntity> {
  GroupListLoaded({@required List<GroupEntity> groups}) : super([groups]) {
    elements = groups;
  }

  @override
  String toString() => '$runtimeType{ '
      'groups: $elements'
      ' }';
}

class GroupListFailure extends GroupListState
    with ElementListFailure<GroupEntity> {
  GroupListFailure({@required dynamic error})
      : assert(error != null, 'No error given'),
        super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
