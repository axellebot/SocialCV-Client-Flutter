import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class IdentityState extends Equatable {
  const IdentityState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class IdentityUninitialized extends IdentityState {}

class IdentityLoading extends IdentityState {}

class IdentityLoaded extends IdentityState {
  final UserEntity user;

  const IdentityLoaded({
    required this.user,
  }) : super();

  @override
  List<Object> get props => super.props..addAll([user]);

  @override
  String toString() => '$runtimeType{ '
      'userModel: $user'
      ' }';
}

class IdentityFailed extends IdentityState {
  final Object error;

  const IdentityFailed({required this.error}) : super();

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
