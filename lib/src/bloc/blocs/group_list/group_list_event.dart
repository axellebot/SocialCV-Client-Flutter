import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// [GroupListEvent] that must be dispatch to [GroupListBloc]
abstract class GroupListEvent extends Equatable {
  GroupListEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class GroupListInitialize extends GroupListEvent
    with ElementListInitialize<GroupEntity> {
  GroupListInitialize({
    String parentPartId,
    String ownerId,
    Cursor cursor,
  })  : assert(
          parentPartId != null && ownerId == null,
          '$GroupListInitialize must be created with a parentId or an ownerId',
        ),
        assert(
          parentPartId == null && ownerId != null,
          '$GroupListInitialize must be created with a parentId or an ownerId',
        ),
        super([parentPartId, ownerId]) {
    this.parentId = parentPartId;
    this.ownerId = ownerId;
    this.cursor = cursor;
  }

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
  GroupListLoadMore({Cursor cursor})
      : assert(cursor != null),
        super([cursor]) {
    this.cursor = cursor;
  }

  @override
  String toString() => '$runtimeType{ '
      'cursor: $cursor'
      ' }';
}
