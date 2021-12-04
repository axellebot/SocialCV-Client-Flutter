import 'dart:async';

import 'package:dio/dio.dart';
import 'package:social_cv_client_flutter/domain.dart';

class ApiInterceptor extends Interceptor {
  late final InterceptorsWrapper _interceptorWrapper;

  ApiInterceptor();

  @override
  FutureOr<void> onError(DioError err, ErrorInterceptorHandler handler) {
    if (err is DioError && err.response != null) {
      final Response? response = err.response;
      final StackTrace? stackTrace =
          (err.error as dynamic).stackTrace as StackTrace;

      final statusCode = err.response?.statusCode;
      final statusMessage = err.response?.statusMessage;

      if (statusCode != null) {
        throw HttpException(
          statusCode: statusCode,
          statusMessage: statusMessage,
          stackTrace: stackTrace ?? StackTrace.current,
        );
      }
    }
    handler.next(err);
  }

  /// Parse response to check if there is any error
  @override
  FutureOr<void> onResponse(
    Response res,
    ResponseInterceptorHandler handler,
  ) {
    // TODO: use Envelop type for Response body
    final Map<String, Object> body = res.data as Map<String, Object>;
    final String? apiErrorCode = body['error'] as String?;
    final String? apiMessage = body['message'] as String?;

    if (apiErrorCode != null) {
      /// TODO : Create real DioError
      handler.reject(DioError(
        requestOptions: res.requestOptions,
        response: res,
        error: apiErrorCode,
      ));

      // throw ApiException.fromDioRequest(
      //   errorCode: apiErrorCode,
      //   message: apiMessage,
      //   stackTrace: StackTrace.current,
      // );
    } else {
      handler.next(res);
    }
  }
}
