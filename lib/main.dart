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

void main() {
  final String _tag = '$main';

  /// SystemChrome.setPreferredOrientations(
  ///     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  /// Global error handler. Show stack trace
  void otherErrorHandler(Object error, StackTrace stack) {
    Logger.fatal('${error}', stackTrace: stack);
  }

  void run() async {
    WidgetsFlutterBinding.ensureInitialized();
    FlutterError.onError = (FlutterErrorDetails errorDetails) {
      FlutterError.presentError(errorDetails);
      Logger.fatal(
        '${errorDetails.exception}',
        stackTrace: errorDetails.stack,
      );
      //exit(1);
    };
    runApp(const ConfigWrapperApp());
  }

  if (DEBUG_MODE) {
    debugPaintSizeEnabled = DEBUG_PAINT_SIZE;
    runZonedGuarded(run, otherErrorHandler);
  } else {
    run();
  }
}
