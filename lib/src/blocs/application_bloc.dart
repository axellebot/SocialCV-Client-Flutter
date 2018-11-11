import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

class THEME {
  static final String LIGHT = "THEME_LIGHT";
  static final String DARK = "THEME_DARK";
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
    _themeController.add(theme);
    SharedPreferencesService.setAppTheme(theme);
  }

  @override
  void dispose() {
    _themeController.close();
  }
}
