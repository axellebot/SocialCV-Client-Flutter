import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class GroupState extends Equatable {
  const GroupState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class GroupUninitialized extends GroupState
    with ElementUninitialized<GroupEntity> {}

class GroupLoading extends GroupState with ElementLoading<GroupEntity> {}

class GroupLoaded extends GroupState with ElementLoaded<GroupEntity> {
  GroupLoaded({required GroupEntity group}) : super() {
    element = group;
  }

  @override
  List<Object> get props => super.props..addAll([element]);

  @override
  String toString() {
    return '$runtimeType{ '
        'group: $element'
        ' }';
  }
}

class GroupFailure extends GroupState with ElementFailure<GroupEntity> {
  GroupFailure({required Object error}) : super() {
    this.error = error;
  }

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType { '
      'error: $error'
      ' }';
}
