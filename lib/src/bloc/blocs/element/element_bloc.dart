import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for profile elements
abstract class ElementBloc<T extends ElementEntity, R, E, S>
    extends Bloc<E, S> {
  final String _tag = '$ElementBloc<$T,$R,$E,$S>';

  final R repository;

  T element;

  ElementBloc({@required this.repository})
      : assert(repository != null, 'No $R given'),
        super();
}
