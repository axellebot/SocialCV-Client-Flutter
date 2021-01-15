import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class PartListState extends Equatable {
  PartListState([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class PartListUninitialized extends PartListState
    with ElementListUninitialized<PartEntity> {}

class PartListLoading extends PartListState
    with ElementListLoading<PartEntity> {
  PartListLoading({int count = 0}) : super([count]) {
    this.count = count;
  }

  @override
  String toString() => '$runtimeType{ '
      'count: $count'
      ' }';
}

class PartListLoaded extends PartListState with ElementListLoaded<PartEntity> {
  PartListLoaded({@required List<PartEntity> parts}) : super([parts]) {
    elements = parts;
  }

  @override
  String toString() => '$runtimeType{ '
      'parts: $elements'
      ' }';
}

class PartListFailure extends PartListState
    with ElementListFailure<PartEntity> {
  PartListFailure({@required dynamic error})
      : assert(error != null, 'No error given'),
        super([error]) {
    this.error = error;
  }

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
