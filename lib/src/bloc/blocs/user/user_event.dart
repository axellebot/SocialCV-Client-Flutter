import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// [UserEvent] that must be dispatch to [UserBloc]

abstract class UserEvent extends Equatable {
  UserEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class UserInitialized extends UserEvent with ElementInitialized<UserEntity> {
  UserInitialized({String userId, UserEntity user})
      : assert(userId != null && user == null),
        assert(userId == null && user != null),
        super([userId, user]) {
    this.elementId = userId;
    this.element = user;
  }

  @override
  String toString() => '$runtimeType{ userId: $elementId, user: $element }';
}

class UserRefresh extends UserEvent with ElementRefresh<UserEntity> {}
