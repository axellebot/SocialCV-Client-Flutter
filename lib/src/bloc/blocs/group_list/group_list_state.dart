import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class GroupListState extends Equatable {
  const GroupListState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class GroupListUninitialized extends GroupListState
    with ElementListUninitialized<GroupEntity> {}

class GroupListLoading extends GroupListState
    with ElementListLoading<GroupEntity> {
  GroupListLoading({int count = 0}) : super() {
    this.count = count;
  }

  @override
  List<Object> get props => super.props..addAll([count]);

  @override
  String toString() => '$runtimeType{ '
      'count: $count'
      ' }';
}

class GroupListLoaded extends GroupListState
    with ElementListLoaded<GroupEntity> {
  GroupListLoaded({required List<GroupEntity?> groups}) : super() {
    elements = groups;
  }

  @override
  List<Object> get props => super.props..addAll([elements]);

  @override
  String toString() => '$runtimeType{ '
      'groups: $elements'
      ' }';
}

class GroupListFailure extends GroupListState
    with ElementListFailure<GroupEntity> {
  GroupListFailure({required Object error}) : super() {
    this.error = error;
  }

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
