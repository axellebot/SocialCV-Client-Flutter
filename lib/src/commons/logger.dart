import 'package:logging/logging.dart';
import 'package:meta/meta.dart';

Logger logger;

void initLogger({@required String package, String tag}) {
  assert(package != null);

  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.time}:${rec.loggerName}: ${rec.level.name} -> ${rec.message}');
  });

  logger = Logger(tag?.toUpperCase() ?? package.toUpperCase());
}
