import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class ProfileState extends Equatable {
  const ProfileState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class ProfileUninitialized extends ProfileState
    with ElementUninitialized<ProfileEntity> {}

class ProfileLoading extends ProfileState with ElementLoading<ProfileEntity> {}

class ProfileLoaded extends ProfileState with ElementLoaded<ProfileEntity> {
  ProfileLoaded({
    required ProfileEntity profile,
  }) : super() {
    element = profile;
  }

  @override
  List<Object> get props => super.props..addAll([element]);

  @override
  String toString() {
    return '$runtimeType{ '
        'element: $element'
        ' }';
  }
}

class ProfileFailure extends ProfileState with ElementFailure<ProfileEntity> {
  ProfileFailure({
    required Object error,
  }) : super() {
    this.error = error;
  }

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
