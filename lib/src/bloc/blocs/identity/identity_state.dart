import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class IdentityState extends Equatable {
  IdentityState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class IdentityUninitialized extends IdentityState {}

class IdentityLoading extends IdentityState {}

class IdentityLoaded extends IdentityState {
  final UserEntity user;

  IdentityLoaded({
    @required this.user,
  }) : super([user]);

  @override
  String toString() => '$runtimeType{ '
      'userModel: $user'
      ' }';
}

class IdentityFailed extends IdentityState {
  final dynamic error;

  IdentityFailed({@required this.error})
      : assert(error != null, 'No error given'),
        super([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
