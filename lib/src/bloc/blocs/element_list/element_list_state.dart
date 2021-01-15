import 'package:social_cv_client_flutter/domain.dart';

mixin ElementListUninitialized<T extends ElementEntity> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementListLoading<T extends ElementEntity> {
  int count;

  @override
  String toString() => '$runtimeType{ '
      'count: $count'
      ' }';
}

mixin ElementListLoaded<T extends ElementEntity> {
  List<T> elements;

  @override
  String toString() => '$runtimeType{ '
      'elements: $elements'
      ' }';
}

mixin ElementListFailure<T extends ElementEntity> {
  dynamic error;

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
