class BaseError {
  BaseError(this.message);

  String message;

  @override
  String toString() {
    return '$message';
  }
}
