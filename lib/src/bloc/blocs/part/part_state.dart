import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class PartState extends Equatable {
  PartState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class PartUninitialized extends PartState
    with ElementUninitialized<PartEntity> {}

class PartLoading extends PartState with ElementLoading<PartEntity> {}

class PartLoaded extends PartState with ElementLoaded<PartEntity> {
  PartLoaded({PartEntity part}) : super([part]) {
    element = part;
  }

  @override
  String toString() {
    return '$runtimeType{ part: $element }';
  }
}

class PartFailure extends PartState with ElementFailure<PartEntity> {
  PartFailure({@required dynamic error})
      : assert(error != null, 'No error given'),
        super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
