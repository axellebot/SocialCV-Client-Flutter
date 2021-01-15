import 'package:meta/meta.dart';

abstract class AppException implements Exception {
  final String message;
  final StackTrace stackTrace;
  final AppExceptionType type;

  const AppException({
    @required this.type,
    this.message,
    this.stackTrace,
  }) : assert(type != null, 'No $AppExceptionType given');
}

enum AppExceptionType {
  /// --------------------------------------------------------------------------
  ///                              Common
  /// --------------------------------------------------------------------------
  somethingWentWrong,

  /// --------------------------------------------------------------------------
  ///                              Server
  /// --------------------------------------------------------------------------
  serverSideProblem,

  /// --------------------------------------------------------------------------
  ///                           Authentication
  /// --------------------------------------------------------------------------
  authNoToken,
  authLoginFailed,
  authRegistrationFailed,
  authAccountAlreadyExists,
  authAccountDisabled,
  authUnauthorized,
  authForbidden,

  /// --------------------------------------------------------------------------
  ///                               User
  /// --------------------------------------------------------------------------
  userNotFound,

  /// --------------------------------------------------------------------------
  ///                               Form
  /// --------------------------------------------------------------------------
  formPasswordWrongPolicy,
}
