import 'dart:async';

import 'package:cv/src/commons/logger.dart';
import 'package:cv/src/errors/api_errors.dart';
import 'package:cv/src/errors/base_errors.dart';
import 'package:cv/src/errors/http_errors.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

String getInitials(String nameString) {
  if (nameString.isEmpty) return " ";

  List<String> nameArray =
      nameString.replaceAll(new RegExp(r"\s+\b|\b\s"), " ").split(" ");
  String initials = ((nameArray[0])[0] != null ? (nameArray[0])[0] : " ") +
      (nameArray.length == 1 ? " " : (nameArray[nameArray.length - 1])[0]);

  return initials;
}

void printException(dynamic e, StackTrace stackTrace, [String message]) {
  if (message != null) {
    debugPrint("$message: $e");
  } else {
    debugPrint(e.toString());
  }
  logger.warning(stackTrace);
}

String translateError(BuildContext context, dynamic err) {
  Localization loc = Localization.of(context);
  logger.warning(err);

  if (err is Exception) {
    if (err is FormatException)
      return loc.exceptionFormatException;
    else if (err is TimeoutException) return loc.exceptionTimeoutException;
  } else if (err is BaseError) {
    // Api Errors
    if (err is ApiErrorWrongPasswordError)
      return loc.apiErrorWrongPasswordError; // HTTP 500
    else if (err is ApiErrorUserNotFoundError)
      return loc.apiErrorUserNotFoundError; // HTTP 501

    // HTTP Client Errors
    if (err is HttpClientErrorBadRequestError)
      return loc.httpClientErrorBadRequest; // HTTP 400
    else if (err is HttpClientErrorPaymentRequiredError)
      return loc.httpClientErrorPaymentRequired; // HTTP 402
    else if (err is HttpClientErrorForbiddenError)
      return loc.httpClientErrorForbidden; // HTTP 403
    else if (err is HttpClientErrorNotFoundError)
      return loc.httpClientErrorNotFound; // HTTP 404
    else if (err is HttpClientErrorMethodNotAllowedError)
      return loc.httpClientErrorMethodNotAllowed; // HTTP 405
    else if (err is HttpClientErrorNotAcceptableError)
      return loc.httpClientErrorNotAcceptable; // HTTP 406
    else if (err is HttpClientErrorRequestTimeoutError)
      return loc.httpClientErrorRequestTimeout; // HTTP 408
    else if (err is HttpClientErrorConflictError)
      return loc.httpClientErrorConflict; // HTTP 409
    else if (err is HttpClientErrorGoneError)
      return loc.httpClientErrorGone; // HTTP 410
    else if (err is HttpClientErrorLengthRequiredError)
      return loc.httpClientErrorLengthRequired; // HTTP 411
    else if (err is HttpClientErrorPayloadTooLargeError)
      return loc.httpClientErrorPayloadTooLarge; // HTTP 413
    else if (err is HttpClientErrorUriTooLongError)
      return loc.httpClientErrorURITooLong; // HTTP 414
    else if (err is HttpClientErrorUnsupportedMediaTypeError)
      return loc.httpClientErrorUnsupportedMediaType; // HTTP 415
    else if (err is HttpClientErrorExpectationFailedError)
      return loc.httpClientErrorExpectationFailed; // HTTP 417
    else if (err is HttpClientErrorUpgradeRequiredError)
      return loc.httpClientErrorUpgradeRequired; // HTTP 426

    // HTTP Server Errors
    if (err is HttpServerErrorInternalServerError)
      return loc.httpServerErrorInternalServerError; // HTTP 500
    else if (err is HttpServerErrorNotImplementedError)
      return loc.httpServerErrorNotImplemented; // HTTP 501
    else if (err is HttpServerErrorBadGatewayError)
      return loc.httpServerErrorBadGateway; // HTTP 502
    else if (err is HttpServerErrorServiceUnavailableError)
      return loc.httpServerErrorServiceUnavailable; // HTTP 503
    else if (err is HttpServerErrorGatewayTimeoutError)
      return loc.httpServerErrorGatewayTimeout; // HTTP 504
    else if (err is HttpServerErrorHttpVersionNotSupportedError)
      return loc.httpServerErrorHttpVersionNotSupported; // HTTP 505
  }
  // Default
  return err.toString();
}
