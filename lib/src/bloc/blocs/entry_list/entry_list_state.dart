import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class EntryListState extends Equatable {
  const EntryListState() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class EntryListUninitialized extends EntryListState
    with ElementListUninitialized<EntryEntity> {}

class EntryListLoading extends EntryListState
    with ElementListLoading<EntryEntity> {
  EntryListLoading({int count = 0}) : super() {
    this.count = count;
  }

  @override
  List<Object?> get props => super.props..addAll([count]);

  @override
  String toString() => '$runtimeType{ '
      'count: $count'
      ' }';
}

class EntryListLoaded extends EntryListState
    with ElementListLoaded<EntryEntity> {
  EntryListLoaded({required List<EntryEntity> entries}) : super() {
    elements = entries;
  }

  @override
  List<Object?> get props => super.props..addAll([elements]);

  @override
  String toString() => '$runtimeType{ '
      'entries: $elements'
      ' }';
}

class EntryListFailure extends EntryListState
    with ElementListFailure<EntryEntity> {
  EntryListFailure({required Object error}) : super() {
    this.error = error;
  }

  @override
  List<Object?> get props => super.props..addAll([error]);

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
