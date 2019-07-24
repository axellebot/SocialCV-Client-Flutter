import 'dart:async';
import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Translate [Error] and [Exception]
String translateError(BuildContext context, dynamic err) {
  Logger.log('Translating error');

  final CVLocalizations loc = CVLocalizations.of(context);

  if (loc == null) return err.toString();

  String txt;

  if (err is Exception) {
    // Exceptions
    if (err is AppException) {
      txt = _translateAppException(context, err);
    } else if (err is HttpException) {
      txt = _translateHttpException(context, err);
    } else if (err is FormatException) {
      txt = loc.exceptionFormatException;
    } else if (err is TimeoutException) {
      txt = loc.exceptionTimeoutException;
    }
  } else if (err is Error) {
    // Errors
    if (err is NotImplementedYetError) {
      txt = loc.errorNotYetImplemented;
    } else if (err is NotSupportedError) {
      txt = loc.errorNotSupported;
    }
  } else if (err is String) {
    txt = err;
  } else {
    txt = '${err.runtimeType}';
  }

  return txt ??=
      '${loc.errorOccurred}: ${err.runtimeType}${err?.message != null ? ' "${err?.message}"' : ''}';
}

/// Translate [HttpException]
String _translateHttpException(BuildContext context, HttpException err) {
  final CVLocalizations loc = CVLocalizations.of(context);
  String txt;
  switch (err.statusCode) {
    case HttpStatus.badRequest:
      // HTTP 400
      txt = loc.http400ClientErrorBadRequest;
      break;
    case HttpStatus.unauthorized:
      // HTTP 401
      txt = loc.http401ClientErrorUnauthorized;
      break;
    case HttpStatus.paymentRequired:
      // HTTP 402
      txt = loc.http402ClientErrorPaymentRequired;
      break;
    case HttpStatus.forbidden:
      // HTTP 403
      txt = loc.http403ClientErrorForbidden;
      break;
    case HttpStatus.notFound:
      // HTTP 404
      txt = loc.http404ClientErrorNotFound;
      break;
    case HttpStatus.methodNotAllowed:
      // HTTP 405
      txt = loc.http405ClientErrorMethodNotAllowed;
      break;
    case HttpStatus.notAcceptable:
      // HTTP 406
      txt = loc.http406ClientErrorNotAcceptable;
      break;
    case HttpStatus.requestTimeout:
      // HTTP 408
      txt = loc.http408ClientErrorRequestTimeout;
      break;
    case HttpStatus.conflict:
      // HTTP 409
      txt = loc.http409ClientErrorConflict;
      break;
    case HttpStatus.gone:
      // HTTP 410
      txt = loc.http410ClientErrorGone;
      break;
    case HttpStatus.lengthRequired:
      // HTTP 411
      txt = loc.http411ClientErrorLengthRequired;
      break;
    case HttpStatus.requestEntityTooLarge:
      // HTTP 413
      txt = loc.http413ClientErrorPayloadTooLarge;
      break;
    case HttpStatus.requestUriTooLong:
      // HTTP 414
      txt = loc.http414ClientErrorURITooLong;
      break;
    case HttpStatus.unsupportedMediaType:
      // HTTP 415
      txt = loc.http415ClientErrorUnsupportedMediaType;
      break;
    case HttpStatus.expectationFailed:
      // HTTP 417
      txt = loc.http417ClientErrorExpectationFailed;
      break;
    case HttpStatus.upgradeRequired:
      // HTTP 426
      txt = loc.http426ClientErrorUpgradeRequired;
      break;
    case HttpStatus.internalServerError:
      // HTTP 500
      txt = loc.http500ServerErrorInternalServerError;
      break;
    case HttpStatus.notImplemented:
      // HTTP 501
      txt = loc.http501ServerErrorNotImplemented;
      break;
    case HttpStatus.badGateway:
      // HTTP 502
      txt = loc.http502ServerErrorBadGateway;
      break;
    case HttpStatus.serviceUnavailable:
      // HTTP 503
      txt = loc.http503ServerErrorServiceUnavailable;
      break;
    case HttpStatus.gatewayTimeout:
      // HTTP 504
      txt = loc.http504ServerErrorGatewayTimeout;
      break;
    case HttpStatus.httpVersionNotSupported:
      // HTTP 505
      txt = loc.http505ServerErrorHttpVersionNotSupported;
      break;
  }
  return txt;
}

/// Translate [AppException]
String _translateAppException(BuildContext context, AppException err) {
  final CVLocalizations loc = CVLocalizations.of(context);
  String txt;

  switch (err.type) {
    case AppExceptionType.somethingWentWrong:
      txt = loc.errorOccurred;
      break;
    case AppExceptionType.authNoToken:
      txt = loc.appErrorAuthNoToken;
      break;
    case AppExceptionType.authLoginFailed:
      txt = loc.authLoginFailed;
      break;
    case AppExceptionType.authRegistrationFailed:
      txt = loc.authRegisterFailed;
      break;
    case AppExceptionType.authAccountAlreadyExists:
      txt = loc.authAccountAlreadyExistsFailure;
      break;
    case AppExceptionType.authAccountDisabled:
      txt = loc.appErrorAuthAccountDisabled;
      break;
    case AppExceptionType.authUnauthorized:
      txt = loc.appErrorAuthUnauthorized;
      break;
    case AppExceptionType.authForbidden:
      txt = loc.appErrorAuthForbidden;
      break;
    case AppExceptionType.userNotFound:
      txt = loc.appErrorUserNotFound;
      break;
    case AppExceptionType.formPasswordWrongPolicy:
      txt = loc.formPasswordWrongPolicy;
      break;
    case AppExceptionType.serverSideProblem:
      txt = loc.appErrorServerSideProblem;
      break;
  }

  return txt;
}
