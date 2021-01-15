import 'package:social_cv_client_flutter/domain.dart';

mixin ElementUninitialized<T extends ElementEntity> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementLoading<T extends ElementEntity> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementLoaded<T extends ElementEntity> {
  T element;

  @override
  String toString() => '$runtimeType{ '
      'element: $element'
      ' }';
}

mixin ElementFailure<T extends ElementEntity> {
  dynamic error;

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
