import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class UserState extends Equatable {
  const UserState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class UserUninitialized extends UserState
    with ElementUninitialized<UserEntity> {}

class UserLoading extends UserState with ElementLoading<UserEntity> {}

class UserLoaded extends UserState with ElementLoaded<UserEntity> {
  UserLoaded({
    required UserEntity user,
  }) : super() {
    element = user;
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

class UserFailure extends UserState with ElementFailure<UserEntity> {
  UserFailure({
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
