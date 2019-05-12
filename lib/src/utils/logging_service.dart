import 'dart:io';

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

enum FatalErrorHandling {
  dumpPopup,
  dumpPopupEmail,
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

class LogEntry {
  final String message;
  final LogType type;
  final Duration time;
  final String stackTrace;
  final int errorCode;
  final bool startup;

  LogEntry({
    @required this.type,
    @required this.time,
    this.message,
    this.errorCode,
    this.stackTrace,
    this.startup = false,
  });

  @override
  String toString() {
    String msg;
    msg = message;

    final err = errorCode != null
        ? (errorCode == ErrorCodes.UNHANDLED_EXCEPTION
            ? 'Unhandled Exception\n'
            : 'Error code: $errorCode. ')
        : '';
    final trace = stackTrace != null ? '\n$stackTrace' : '';
    final start = startup ? '[startup]' : '';
    return '[${time.inSeconds}.${time.inMilliseconds % 1000}]$start $err$msg$trace';
  }
}

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                              Logging service                               //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////

class LoggingService {
  static const _LOG_LENGTH = 256;
  static const _ACTIONS_LOG_LENGTH = 10;
  static final _instance = LoggingService._newInstance();

  final DateTime _startupTime = DateTime.now();
  List _startupLog = List<LogEntry>();
  List _messagesLog = List<LogEntry>(_LOG_LENGTH);
  List _actionsLog = List<LogEntry>(_ACTIONS_LOG_LENGTH);

  File _logFile;

  int nextLogPos = 0;
  int nextActionPos = 0;

  static const String INFO = 'info';
  static const String ERROR = 'error';

  final fatalErrorsHandling = FatalErrorHandling.dumpPopupEmail;

  bool startupPhase = true;

  Duration get runtime {
    return DateTime.now().difference(_startupTime);
  }

  // -----------------------------------------------------------------------
  //                            Constructor
  // -----------------------------------------------------------------------

  LoggingService._newInstance() : super();

  factory LoggingService() {
    return _instance;
  }

  // -----------------------------------------------------------------------
  //                            Initialization
  // -----------------------------------------------------------------------

  ///
  /// Init local log file
  ///
  Future<void> init() async {
//    _logFile = await appStorageService.addFile('log.txt', 'log', '');
  }

  // -----------------------------------------------------------------------
  //                              General log
  // -----------------------------------------------------------------------

  ///
  /// Print the message and add a new log entry to the log list
  ///
  void doLog(
    String message, {
    LogType type = LogType.log,
    int errorCode,
    String stackTrace,
  }) {
    if (message == null || message == '' || message == ' ') {
      message = '           ----';
    }
    final entry = LogEntry(
      type: type,
      time: runtime,
      message: message,
      errorCode: errorCode,
      stackTrace: stackTrace,
      startup: startupPhase,
    );
    if (startupPhase) {
      _startupLog.add(entry);
    } else {
      _messagesLog[nextLogPos] = entry;
      nextLogPos = (nextLogPos + 1) % _messagesLog.length;
    }
    print(entry);
  }

  ///
  /// Static log function
  ///
  static void log(String message) => _instance.doLog(message);

  // -----------------------------------------------------------------------
  //                               Warning
  // -----------------------------------------------------------------------

  ///
  /// Do warning log. Use this when something is (probably) wrong
  /// but the execution will likely be continued without any serious
  /// errors.
  ///
  void doWarning(String message) {
    doLog(message, type: LogType.warning);
  }

  ///
  /// Static warning function
  ///
  static void warning(String message) => _instance.doWarning(message);

  // -----------------------------------------------------------------------
  //                                Info
  // -----------------------------------------------------------------------

  ///
  /// Do info log. Use this for general information like startup information.
  ///
  void doInfo(String message, {String title, int autoCloseSeconds = -1}) {
    if (title == null) {
      title = INFO;
    }
    doLog(message);
//    return doDialog(message, title, null, null, Dialog.OK, null, null,
//        dialogSize, null, autoCloseSeconds);
  }

  ///
  /// Static info function
  ///
  static void info(String message, {String title, int autoCloseSeconds = -1}) =>
      _instance.doInfo(message, title: title);

  // -----------------------------------------------------------------------
  //                                 Error
  // -----------------------------------------------------------------------

  ///
  /// Do error log. Something went wrong, the app will not continue the
  /// way it is meant to be.
  ///
  void doError(String message, errorCode, {autoCloseSeconds = -1}) {
    final title = '$ERROR ${errorCode != 0 ? errorCode : ''}';

    doLog(message, type: LogType.error);

//    return doDialog(message, title, null, null, Dialog.OK, null, null,
//        dialogSize, null, autoCloseSeconds);
  }

  ///
  /// Static error function
  ///
  static void error(String message, {int errorCode}) =>
      _instance.doError(message, errorCode);

  // -----------------------------------------------------------------------
  //                                Fatal
  // -----------------------------------------------------------------------

  ///
  /// Fatal error. Something went wrong, the app will not continue the
  /// way it is meant to be and a mail with error details must be
  /// send to us.
  ///
  void doFatal(String message, int errorCode, {String stackTrace}) {
    doLog(message,
        type: LogType.fatal, errorCode: errorCode, stackTrace: stackTrace);

    doWarning('Fatal error not handled');
  }

  ///
  /// Static fatal function
  ///
  static void fatal(String message, {int errorCode, String stackTrace}) =>
      _instance.doFatal(message, errorCode, stackTrace: stackTrace);

  // -----------------------------------------------------------------------
  //                            Log list
  // -----------------------------------------------------------------------

  static get logList => _instance._logList;

  get _logList {
    final List<LogEntry> log = _startupLog + _messagesLog + _actionsLog;
    log.removeWhere((e) => e == null);
    log.sort((a, b) => a.time > b.time ? 1 : -1);
    return log;
  }

  static get logString => _instance._logString;

  get _logString {
    return _logList.join('\n');
  }

//  Future _sendLog() async {
//    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
//    AndroidDeviceInfo i = await deviceInfo.androidInfo;
//    final version = {
//      'baseOS': i.version.baseOS,
//      'codename': i.version.codename,
//      'incremental': i.version.incremental,
//      'previewSdkInt': i.version.previewSdkInt,
//      'release': i.version.release,
//      'sdkInt': i.version.sdkInt,
//      'securityPatch': i.version.securityPatch,
//    };
//
//    final info = {
//      'android id': i.androidId,
//      'isPhysicalDevice': i.isPhysicalDevice,
//      'type': i.type,
//      'version': version,
//      'device': i.device,
//      'brand': i.brand,
//      'manufacturer': i.manufacturer,
//      'model': i.model,
//      'product': i.product,
//      'display': i.display,
//      'fingerprint': i.fingerprint,
//      'hardware': i.hardware,
//      'host': i.host,
//      'id': i.id,
//      'tags': i.tags,
//      'board': i.board,
//      'bootloader': i.bootloader,
//    };
//
//  }
}
