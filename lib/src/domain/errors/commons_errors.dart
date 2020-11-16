class NotImplementedYetError extends Error {
  final String message;

  NotImplementedYetError([this.message]);

  @override
  String toString() => message != null
      ? 'NotImplementedYetError: $message'
      : 'NotImplementedYetError';
}

class NotSupportedError extends Error {
  final String message;

  NotSupportedError(this.message);

  @override
  String toString() => 'Unsupported operation: $message';
}
