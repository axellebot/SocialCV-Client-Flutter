import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/commons/logger.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

class THEME {
  static const String LIGHT = "THEME_LIGHT";
  static const String DARK = "THEME_DARK";
}

class ApplicationBloc extends BlocBase {
  ApplicationBloc() : super();

  // Rx Variables
  final _themeController = BehaviorSubject<String>();

  // Streams
  Observable<String> get themeStream => _themeController.stream;

  /* Functions */
  // Human functions
  void setTheme(String theme) {
    logger.info('setTheme $theme');
    _themeController.add(theme);
    SharedPreferencesService.setAppTheme(theme);
  }

  @override
  void dispose() {
    _themeController.close();
  }
}
