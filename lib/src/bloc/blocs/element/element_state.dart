mixin ElementUninitialized<T> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementLoading<T> {
  @override
  String toString() => '$runtimeType{}';
}

mixin ElementLoaded<T> {
  late final T element;

  @override
  String toString() => '$runtimeType{ '
      'element: $element'
      ' }';
}

mixin ElementFailure<T> {
  late final Object error;

  @override
  String toString() => '$runtimeType{ '
      'error: $error'
      ' }';
}
