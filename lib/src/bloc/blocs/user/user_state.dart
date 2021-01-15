import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class UserState extends Equatable {
  UserState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class UserUninitialized extends UserState
    with ElementUninitialized<UserEntity> {}

class UserLoading extends UserState with ElementLoading<UserEntity> {}

class UserLoaded extends UserState with ElementLoaded<UserEntity> {
  UserLoaded({UserEntity user}) : super([user]) {
    element = user;
  }

  @override
  String toString() {
    return '$runtimeType{ '
        'element: $element'
        ' }';
  }
}

class UserFailure extends UserState with ElementFailure<UserEntity> {
  UserFailure({@required dynamic error})
      : assert(error != null, 'No error given'),
        super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
