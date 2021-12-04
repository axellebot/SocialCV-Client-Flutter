class CacheModel<T> {
  CacheModel({
    required this.model,
    required this.expiration,
  });

  T model;
  DateTime expiration;

  bool isExpired() {
    return DateTime.now().compareTo(expiration) >= 0 ? true : false;
  }
}
