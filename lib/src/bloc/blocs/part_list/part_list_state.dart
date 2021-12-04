import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class PartListState extends Equatable {
  const PartListState() : super();

  @override
  List<Object> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class PartListUninitialized extends PartListState
    with ElementListUninitialized<PartEntity> {}

class PartListLoading extends PartListState
    with ElementListLoading<PartEntity> {
  PartListLoading({int count = 0}) : super() {
    this.count = count;
  }

  @override
  List<Object> get props => super.props..addAll([count]);

  @override
  String toString() => '$runtimeType{ '
      'count: $count'
      ' }';
}

class PartListLoaded extends PartListState with ElementListLoaded<PartEntity> {
  PartListLoaded({required List<PartEntity?> parts}) : super() {
    elements = parts;
  }

  @override
  List<Object> get props => super.props..addAll([elements]);

  @override
  String toString() => '$runtimeType{ '
      'parts: $elements'
      ' }';
}

class PartListFailure extends PartListState
    with ElementListFailure<PartEntity> {
  PartListFailure({required Object error}) : super() {
    this.error = error;
  }

  @override
  List<Object> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
