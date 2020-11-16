import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class ProfileListState extends Equatable {
  ProfileListState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class ProfileListUninitialized extends ProfileListState
    with ElementListUninitialized<ProfileEntity> {}

class ProfileListLoading extends ProfileListState
    with ElementListLoading<ProfileEntity> {
  ProfileListLoading({int count = 0}) : super([count]) {
    this.count = count;
  }

  @override
  String toString() => '$runtimeType{ '
      'count: $count'
      ' }';
}

class ProfileListLoaded extends ProfileListState
    with ElementListLoaded<ProfileEntity> {
  ProfileListLoaded({@required List<ProfileEntity> profiles})
      : super([profiles]) {
    elements = profiles;
  }

  @override
  String toString() => '$runtimeType{ '
      'profiles: $elements'
      ' }';
}

class ProfileListFailure extends ProfileListState
    with ElementListFailure<ProfileEntity> {
  ProfileListFailure({@required dynamic error})
      : assert(error != null, 'No error given'),
        super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
