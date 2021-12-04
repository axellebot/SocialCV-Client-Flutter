import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// [UserEvent] that must be dispatch to [UserBloc]

abstract class UserEvent extends Equatable {
  const UserEvent() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class UserInitialize extends UserEvent with ElementInitialize<UserEntity> {
  UserInitialize({
    String? userId,
    UserEntity? user,
  })  : assert(userId != null && user == null),
        assert(userId == null && user != null),
        super() {
    elementId = userId;
    element = user;
  }

  @override
  List<Object?> get props => super.props..addAll([elementId, element]);

  @override
  String toString() => '$runtimeType{ '
      'userId: $elementId, '
      'user: $element'
      ' }';
}

class UserRefresh extends UserEvent with ElementRefresh<UserEntity> {}
