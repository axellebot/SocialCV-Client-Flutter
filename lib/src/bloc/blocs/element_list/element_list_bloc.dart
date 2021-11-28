import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Business Logic Component for profile element list
/// - [R] repository
/// - [E] event class
/// - [S] state class
abstract class ElementListBloc<T extends ElementEntity, R, E, S>
    extends Bloc<E, S> {
  final String _tag = '$ElementListBloc<$T>';

  final R repository;

  String parentId;
  List<T> elements;
  String ownerId;

  Cursor cursor;

  /// TODO: Add filter
  /// TODO: Add sort

  ElementListBloc({
    @required this.repository,
    @required S initialState,
  })  : assert(repository != null, 'No $R given'),
        assert(initialState != null, 'No $S given'),
        super(initialState);
}
