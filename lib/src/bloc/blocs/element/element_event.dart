import 'package:social_cv_client_flutter/domain.dart';

mixin ElementInitialized<T extends ElementEntity> {
  String elementId;
  T element;

  @override
  String toString() => '$runtimeType{ '
      'id: $elementId, '
      'element: $element'
      ' }';
}

mixin ElementRefresh<T extends ElementEntity> {
  @override
  String toString() => '$runtimeType{}';
}
