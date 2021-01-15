import 'package:meta/meta.dart';

class CacheModel<T> {
  CacheModel({
    @required this.model,
    @required this.expiration,
  })  : assert(model != null),
        assert(model != null);

  T model;
  DateTime expiration;

  bool isExpired() {
    return DateTime.now().compareTo(expiration) >= 0 ? true : false;
  }
}
