import 'package:cv/src/errors/base_errors.dart';

// HTTP 400
class HttpClientErrorBadRequestError extends BaseError {
  HttpClientErrorBadRequestError() : super("Bad Message");
}

// HTTP 402
class HttpClientErrorPaymentRequiredError extends BaseError {
  HttpClientErrorPaymentRequiredError() : super("Payment Required");
}

// HTTP 403
class HttpClientErrorForbiddenError extends BaseError {
  HttpClientErrorForbiddenError() : super("Forbidden");
}

// HTTP 404
class HttpClientErrorNotFoundError extends BaseError {
  HttpClientErrorNotFoundError() : super("Not found");
}

// HTTP 405
class HttpClientErrorMethodNotAllowedError extends BaseError {
  HttpClientErrorMethodNotAllowedError() : super("Method Not Allowed");
}

// HTTP 406
class HttpClientErrorNotAcceptableError extends BaseError {
  HttpClientErrorNotAcceptableError() : super("Not Acceptable");
}

// HTTP 408
class HttpClientErrorRequestTimeoutError extends BaseError {
  HttpClientErrorRequestTimeoutError() : super("Request Timeout");
}

// HTTP 409
class HttpClientErrorConflictError extends BaseError {
  HttpClientErrorConflictError() : super("Conflict");
}

// HTTP 410
class HttpClientErrorGoneError extends BaseError {
  HttpClientErrorGoneError() : super("Gone");
}

// HTTP 411
class HttpClientErrorLengthRequiredError extends BaseError {
  HttpClientErrorLengthRequiredError() : super("Length Required");
}

// HTTP 413
class HttpClientErrorPayloadTooLargeError extends BaseError {
  HttpClientErrorPayloadTooLargeError() : super("Payload Too Large");
}

// HTTP 414
class HttpClientErrorUriTooLongError extends BaseError {
  HttpClientErrorUriTooLongError() : super("URI Too Long");
}

// HTTP 415
class HttpClientErrorUnsupportedMediaTypeError extends BaseError {
  HttpClientErrorUnsupportedMediaTypeError() : super("Unsupported Media Type");
}

// HTTP 417
class HttpClientErrorExpectationFailedError extends BaseError {
  HttpClientErrorExpectationFailedError() : super("Expectation Failed");
}

// HTTP 426
class HttpClientErrorUpgradeRequiredError extends BaseError {
  HttpClientErrorUpgradeRequiredError() : super("Upgrade Required");
}

// HTTP 500
class HttpServerErrorInternalServerError extends BaseError {
  HttpServerErrorInternalServerError() : super("Internal Server Error");
}

// HTTP 501
class HttpServerErrorNotImplementedError extends BaseError {
  HttpServerErrorNotImplementedError() : super("Not Implemented");
}

// HTTP 502
class HttpServerErrorBadGatewayError extends BaseError {
  HttpServerErrorBadGatewayError() : super("Bad Gateway");
}

// HTTP 503
class HttpServerErrorServiceUnavailableError extends BaseError {
  HttpServerErrorServiceUnavailableError() : super("Service Unavailable");
}

// HTTP 504
class HttpServerErrorGatewayTimeoutError extends BaseError {
  HttpServerErrorGatewayTimeoutError() : super("Gateway Timeout");
}

// HTTP 505
class HttpServerErrorHttpVersionNotSupportedError extends BaseError {
  HttpServerErrorHttpVersionNotSupportedError()
      : super("HTTP Version Not Supported");
}
