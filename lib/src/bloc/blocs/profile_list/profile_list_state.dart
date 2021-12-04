import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class ProfileListState extends Equatable {
  const ProfileListState() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class ProfileListUninitialized extends ProfileListState
    with ElementListUninitialized<ProfileEntity> {}

class ProfileListLoading extends ProfileListState
    with ElementListLoading<ProfileEntity> {
  ProfileListLoading({
    int count = 0,
  }) : super() {
    this.count = count;
  }

  @override
  List<Object?> get props => super.props..addAll([count]);

  @override
  String toString() => '$runtimeType{ '
      'count: $count'
      ' }';
}

class ProfileListLoaded extends ProfileListState
    with ElementListLoaded<ProfileEntity> {
  ProfileListLoaded({
    required List<ProfileEntity> profiles,
  }) : super() {
    elements = profiles;
  }

  @override
  List<Object?> get props => super.props..addAll([elements]);

  @override
  String toString() => '$runtimeType{ '
      'profiles: $elements'
      ' }';
}

class ProfileListFailure extends ProfileListState
    with ElementListFailure<ProfileEntity> {
  ProfileListFailure({
    required Object error,
  }) : super() {
    this.error = error;
  }

  @override
  List<Object?> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
