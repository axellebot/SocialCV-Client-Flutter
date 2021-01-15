import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class ProfileState extends Equatable {
  ProfileState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class ProfileUninitialized extends ProfileState
    with ElementUninitialized<ProfileEntity> {}

class ProfileLoading extends ProfileState with ElementLoading<ProfileEntity> {}

class ProfileLoaded extends ProfileState with ElementLoaded<ProfileEntity> {
  ProfileLoaded({ProfileEntity profile}) : super([profile]) {
    element = profile;
  }

  @override
  String toString() {
    return '$runtimeType{ '
        'element: $element'
        ' }';
  }
}

class ProfileFailure extends ProfileState with ElementFailure<ProfileEntity> {
  ProfileFailure({@required dynamic error})
      : assert(error != null, 'No error given'),
        super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
