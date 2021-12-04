import 'package:flutter/material.dart';

class RepositoryProvider<CVRepository> extends InheritedWidget {
  static Type typeOf<T>() => T;

  final CVRepository repository;

  const RepositoryProvider({
    Key? key,
    required Widget child,
    required this.repository,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget _) => false;

  static T? of<T extends Object>(BuildContext context) {
    return context
        .getElementForInheritedWidgetOfExactType<RepositoryProvider<T>>() as T?;
  }
}
