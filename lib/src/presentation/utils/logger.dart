import 'dart:async';

import 'package:meta/meta.dart';

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                           Helper classes and enums                         //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

enum LogType {
  log,
  info,
  warning,
  error,
  fatal,
}

class ErrorCodes {
  static const int UNHANDLED_EXCEPTION = 1;
  static const int LOGIN_FAILED = 20;
  static const int DOWNLOAD_FAILED = 30;
  static const int OPEN_DB_FAILED = 40;
}

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                 Log entry                                  //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

/// A class that define a log entry
class LogEntry {
  final String title;
  final String message;
  final int errorCode;
  final Duration time;
  final StackTrace stackTrace;
  final LogType type;

  LogEntry({
    this.title,
    this.message,
    @required this.type,
    @required this.time,
    this.errorCode,
    this.stackTrace,
  });

  @override
  String toString() {
    final err = errorCode != null
        ? (errorCode == ErrorCodes.UNHANDLED_EXCEPTION
            ? "Unhandled Exception\n"
            : "Error code: $errorCode. ")
        : "";
    final trace = stackTrace != null ? "\n$stackTrace" : '';

    final mess = (title != null) ? '$title:$message' : message;

    return '[${time.toString()}] $err $mess ${trace ?? ''}';
  }
}

/// ----------------------------------------------------------------------------
///                           Logger
/// ----------------------------------------------------------------------------

/// A class that provide logging services
class Logger {
  static const _LOG_LENGTH = 256;
  static const _ACTIONS_LOG_LENGTH = 10;
  static final _instance = Logger._newInstance();

  final DateTime _startupTime = DateTime.now();

  final List<LogEntry> _messagesLog = List<LogEntry>(_LOG_LENGTH);

  int nextLogPos = 0;
  int nextActionPos = 0;

  static const String INFO = "info";
  static const String ERROR = "error";

  Duration get runtime {
    return DateTime.now().difference(_startupTime);
  }

  /// --------------------------------------------------------------------------
  ///                            Constructor
  /// --------------------------------------------------------------------------
  Logger._newInstance() : super();

  factory Logger() {
    return _instance;
  }

  /// --------------------------------------------------------------------------
  ///                            Initialization
  /// --------------------------------------------------------------------------

  ///
  /// Init local log file
  ///
  FutureOr<void> init() async {
    //_logFile = await localStorageManager.getDocumentsFile("log.txt");
  }

  /// --------------------------------------------------------------------------
  ///                              General log
  /// --------------------------------------------------------------------------

  /// Print the message and add a new log entry to the log list
  void doLog(
    String message, {
    String title,
    LogType type = LogType.log,
    int errorCode,
    StackTrace stackTrace,
  }) {
    if (message == null || message == "" || message == " ") {
      message = "           ----";
    }
    final entry = LogEntry(
      message: message,
      title: title,
      type: type,
      time: runtime,
      errorCode: errorCode,
      stackTrace: stackTrace,
    );

    _messagesLog[nextLogPos] = entry;
    nextLogPos = (nextLogPos + 1) % _messagesLog.length;

    print(entry);
  }

  ///
  /// Static log function
  ///
  static void log(String message) => _instance.doLog(message);

  /// -----------------------------------------------------------------------
  ///                               Warning
  /// -----------------------------------------------------------------------

  ///
  /// Do warning log. Use this when something is (probably) wrong
  /// but the execution will likely be continued without any serious
  /// errors.
  ///
  void doWarning(String message, {StackTrace stackTrace}) {
    doLog(message, type: LogType.warning, stackTrace: stackTrace);
  }

  ///
  /// Static warning function
  ///
  static void warning(String message, {StackTrace stackTrace}) =>
      _instance.doWarning(message, stackTrace: stackTrace);

  /// -----------------------------------------------------------------------
  ///                                Info
  /// -----------------------------------------------------------------------

  /// Do info log. Use this for general information like startup information.
  void doInfo(String message,
      {String title, int autoCloseSeconds = -1, StackTrace stackTrace}) {
    doLog(message,
        title: title ?? INFO, type: LogType.info, stackTrace: stackTrace);
  }

  /// Static info function
  static void info(String message, {String title, int autoCloseSeconds = -1}) {
    _instance.doInfo(
      message,
      title: title,
      autoCloseSeconds: autoCloseSeconds,
    );
  }

  // -----------------------------------------------------------------------
  //                                 Error
  // -----------------------------------------------------------------------

  /// Do error log. Something went wrong, the app will not continue the
  /// way it is meant to be.
  void doError(
    String message,
    errorCode, {
    String title,
    autoCloseSeconds = -1,
    StackTrace stackTrace,
  }) {
    final title = "$ERROR ${errorCode != 0 ? errorCode : ''}";

    doLog(message, title: title, type: LogType.error, stackTrace: stackTrace);
  }

  /// Static error function
  static void error(String message, {int errorCode, StackTrace stackTrace}) =>
      _instance.doError(message, errorCode, stackTrace: stackTrace);

  // -----------------------------------------------------------------------
  //                                Fatal
  // -----------------------------------------------------------------------

  /// Fatal error. Something went wrong, the app will not continue the
  /// way it is meant to be and a mail with error details must be
  /// send to us.
  void doFatal(String message, int errorCode, {StackTrace stackTrace}) {
    doLog(message,
        type: LogType.fatal, errorCode: errorCode, stackTrace: stackTrace);
  }

  /// Static fatal function
  static void fatal(String message, {int errorCode, StackTrace stackTrace}) =>
      _instance.doFatal(message, errorCode, stackTrace: stackTrace);

  /// -----------------------------------------------------------------------
  ///                            Log list
  /// -----------------------------------------------------------------------

  static get logList => _instance._logList;

  List<LogEntry> get _logList {
    final List<LogEntry> logs = _messagesLog;
    logs.removeWhere((e) => e == null);
    logs.sort((a, b) => a.time > b.time ? 1 : -1);
    return logs;
  }

  static get logString => _instance._logString;

  get _logString {
    return _logList.join("\n");
  }
}
