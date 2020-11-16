import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:social_cv_client_flutter/src/presentation/app.dart';
import 'package:social_cv_client_flutter/src/presentation/utils/logger.dart';

/// TODO: automatically set this to false for release builds
// ignore: constant_identifier_names
const bool DEBUG_MODE = true;
// ignore: constant_identifier_names
const bool DEBUG_PAINT_SIZE = false;

FutureOr<void> main() async {
  String _tag = '$main';

  /// SystemChrome.setPreferredOrientations(
  ///     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  void run() async {
    runApp(ConfigWrapperApp());
  }

  FlutterError.onError = globalErrorHandler;

  if (DEBUG_MODE) {
    debugPaintSizeEnabled = DEBUG_PAINT_SIZE;
    run();
  } else {
    runZoned(run, onError: globalErrorHandler);
  }
}

/// Global error handler. Show stack trace
void globalErrorHandler(details) {
  StackTrace stackTrace;

  if (details is FlutterErrorDetails) {
    if (details.exception is Error) {
      stackTrace = details.stack;
    }
  } else if (details is Error) {
    stackTrace = details.stackTrace;
  } else {
    Logger.fatal(
      '${details.runtimeType}',
      errorCode: ErrorCodes.UNHANDLED_EXCEPTION,
    );
    throw details;
  }

  Logger.error('${details.runtimeType}', stackTrace: stackTrace);
}
