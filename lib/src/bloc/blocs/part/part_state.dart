import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class PartState extends Equatable {
  const PartState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class PartUninitialized extends PartState
    with ElementUninitialized<PartEntity> {}

class PartLoading extends PartState with ElementLoading<PartEntity> {}

class PartLoaded extends PartState with ElementLoaded<PartEntity> {
  PartLoaded({
    required PartEntity part,
  }) : super() {
    element = part;
  }

  @override
  List<Object> get props => super.props..addAll([element]);

  @override
  String toString() {
    return '$runtimeType{ '
        'part: $element'
        ' }';
  }
}

class PartFailure extends PartState with ElementFailure<PartEntity> {
  PartFailure({required Object error}) : super() {
    this.error = error;
  }

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
