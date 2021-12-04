import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// [ProfileListEvent] that must be dispatch to [ProfileListBloc]
abstract class ProfileListEvent extends Equatable {
  const ProfileListEvent() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class ProfileListInitialize extends ProfileListEvent
    with ElementListInitialize<ProfileEntity> {
  ProfileListInitialize({
    String? parentUserId,
    String? ownerId,
    required Cursor cursor,
  })  : assert(
          parentUserId != null && ownerId == null,
          '$ProfileListInitialize must be created with a parentId or an ownerId',
        ),
        assert(
          parentUserId == null && ownerId != null,
          '$ProfileListInitialize must be created with a parentId or an ownerId',
        ),
        super() {
    parentId = parentUserId;
    this.ownerId = ownerId;
    this.cursor = cursor;
  }

  @override
  List<Object?> get props => super.props..addAll([parentId, ownerId, cursor]);

  @override
  String toString() => '$runtimeType{ '
      'parentUserId: $parentId, '
      'ownerId: $ownerId, '
      'cursor: $cursor'
      ' }';
}

class ProfileListRefresh extends ProfileListEvent
    with ElementListRefresh<ProfileEntity> {}

class ProfileListLoadMore extends ProfileListEvent
    with ElementListLoadMore<ProfileEntity> {
  ProfileListLoadMore({required Cursor cursor}) : super() {
    this.cursor = cursor;
  }

  @override
  List<Object?> get props => super.props..addAll([cursor]);

  @override
  String toString() => '$runtimeType{ '
      'cursor: $cursor'
      ' }';
}
