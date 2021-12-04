import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// [PartListEvent] that must be dispatch to [PartListBloc]
abstract class PartListEvent extends Equatable {
  const PartListEvent() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class PartListInitialize extends PartListEvent
    with ElementListInitialize<PartEntity> {
  PartListInitialize({
    String? parentProfileId,
    String? ownerId,
    required Cursor cursor,
  })  : assert(
          parentProfileId != null && ownerId == null,
          '$PartListInitialize must be created with a parentId or an ownerId',
        ),
        assert(
          parentProfileId == null && ownerId != null,
          '$PartListInitialize must be created with a parentId or an ownerId',
        ),
        super() {
    parentId = parentProfileId;
    this.ownerId = ownerId;
    this.cursor = cursor;
  }

  @override
  List<Object?> get props => super.props..addAll([parentId, ownerId, cursor]);

  @override
  String toString() => '$runtimeType{ '
      'parentProfileId: $parentId, '
      'ownerId: $ownerId, '
      'cursor: $cursor'
      ' }';
}

class PartListRefresh extends PartListEvent
    with ElementListRefresh<PartEntity> {}

class PartListLoadMore extends PartListEvent
    with ElementListLoadMore<PartEntity> {
  PartListLoadMore({
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
