import 'package:meta/meta.dart';

class HttpException implements Exception {
  final int statusCode;
  final String statusMessage;
  final StackTrace stackTrace;

  const HttpException({
    @required this.statusCode,
    this.statusMessage,
    this.stackTrace,
  }) : assert(statusCode != null, 'No status code given');
}
