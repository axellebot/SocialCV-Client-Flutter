import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// [EntryListEvent] that must be dispatch to [EntryListBloc]
abstract class EntryListEvent extends Equatable {
  const EntryListEvent() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class EntryListInitialize extends EntryListEvent
    with ElementListInitialize<EntryEntity> {
  EntryListInitialize({
    String? parentGroupId,
    String? ownerId,
    required Cursor cursor,
  }) : super() {
    parentId = parentGroupId;
    this.ownerId = ownerId;
    this.cursor = cursor;
  }

  @override
  List<Object?> get props => super.props..addAll([parentId, ownerId, cursor]);

  @override
  String toString() => '$runtimeType{ '
      'parentId: $parentId, '
      'ownerId: $ownerId, '
      'cursor: $cursor'
      ' }';
}

class EntryListRefresh extends EntryListEvent
    with ElementListRefresh<EntryEntity> {}

class EntryListLoadMore extends EntryListEvent
    with ElementListLoadMore<EntryEntity> {
  EntryListLoadMore({
    required Cursor cursor,
  }) : super() {
    this.cursor = cursor;
  }

  @override
  List<Object?> get props => super.props..addAll([cursor]);

  @override
  String toString() => '$runtimeType{ '
      'cursor: $cursor'
      ' }';
}
