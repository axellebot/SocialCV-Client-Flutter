import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// [GroupListEvent] that must be dispatch to [GroupListBloc]
abstract class GroupListEvent extends Equatable {
  const GroupListEvent() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class GroupListInitialize extends GroupListEvent
    with ElementListInitialize<GroupEntity> {
  GroupListInitialize({
    String? parentPartId,
    String? ownerId,
    required Cursor cursor,
  })  : assert(
          parentPartId != null && ownerId == null,
          '$GroupListInitialize must be created with a parentId or an ownerId',
        ),
        assert(
          parentPartId == null && ownerId != null,
          '$GroupListInitialize must be created with a parentId or an ownerId',
        ),
        super() {
    parentId = parentPartId;
    this.ownerId = ownerId;
    this.cursor = cursor;
  }

  @override
  List<Object?> get props => super.props..addAll([parentId, ownerId, cursor]);

  @override
  String toString() => '$runtimeType{ '
      'parentPartId: $parentId, '
      'ownerId: $ownerId, '
      'cursor: $cursor'
      ' }';
}

class GroupListRefresh extends GroupListEvent
    with ElementListRefresh<GroupEntity> {}

class GroupListLoadMore extends GroupListEvent
    with ElementListLoadMore<GroupEntity> {
  GroupListLoadMore({required Cursor cursor}) : super() {
    this.cursor = cursor;
  }

  @override
  List<Object?> get props => super.props..addAll([cursor]);

  @override
  String toString() => '$runtimeType{ '
      'cursor: $cursor'
      ' }';
}
