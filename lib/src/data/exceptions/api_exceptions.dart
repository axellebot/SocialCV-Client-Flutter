import 'package:social_cv_client_flutter/domain.dart';

class ApiException extends AppException {
  ApiException._internal({
    required AppExceptionType type,
    String? message,
    StackTrace? stackTrace,
  }) : super(type: type, message: message, stackTrace: stackTrace);

  factory ApiException.fromDioRequest({
    required String errorCode,
    String? message,
    StackTrace? stackTrace,
  }) {
    final AppExceptionType? errorType = _apiErrorCodes[errorCode];

    return ApiException._internal(
      type: errorType ?? AppExceptionType.somethingWentWrong,
      message: message,
      stackTrace: stackTrace,
    );
  }
}

/// Error map between api errors and domain exception types
Map<String, AppExceptionType> _apiErrorCodes = {
  /// --------------------------------------------------------------------------
  ///                              Server
  /// --------------------------------------------------------------------------

  'SERVER_ERROR': AppExceptionType.serverSideProblem,

  /// --------------------------------------------------------------------------
  ///                           Authentication
  /// --------------------------------------------------------------------------

  'AUTH_LOGIN_FAILED': AppExceptionType.authLoginFailed,
  'AUTH_REGISTRATION_FAILED': AppExceptionType.authRegistrationFailed,
  'AUTH_ACCOUNT_ALREADY_EXISTS': AppExceptionType.authAccountAlreadyExists,
  'AUTH_ACCOUNT_DISABLED': AppExceptionType.authAccountDisabled,
  'AUTH_NOT_AUTHORIZED': AppExceptionType.authUnauthorized,
  'AUTH_FORBIDDEN': AppExceptionType.authForbidden,

  /// --------------------------------------------------------------------------
  ///                               User
  /// --------------------------------------------------------------------------

  'USER_NOT_FOUND': AppExceptionType.userNotFound,

  /// --------------------------------------------------------------------------
  ///                               Form
  /// --------------------------------------------------------------------------

  'FORM_PASSWORD_WRONG_POLICY': AppExceptionType.formPasswordWrongPolicy,
};
