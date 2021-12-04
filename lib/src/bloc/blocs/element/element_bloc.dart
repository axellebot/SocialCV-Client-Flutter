import 'package:bloc/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/src/domain/repositories/entity_repository.dart';

/// Business Logic Component for profile elements
abstract class ElementBloc<T extends ElementEntity, R extends EntityRepository,
    E, S> extends Bloc<E, S> {
  final String _tag = '$ElementBloc<$T,$R,$E,$S>';

  final R repository;

  T? element;

  ElementBloc({
    required this.repository,
    required S initialState,
  }) : super(initialState);
}
