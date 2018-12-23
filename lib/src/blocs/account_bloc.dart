import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

class AccountBloc extends BlocBase {
  AccountBloc() : super() {
    _isAuthenticatedController.add(false);
    _isLogingController.add(false);
    _isFetchingAccountDetailsController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _isAuthenticatedController = BehaviorSubject<bool>();
  final _isLogingController = BehaviorSubject<bool>();
  final _isFetchingAccountDetailsController = BehaviorSubject<bool>();
  final _accountDetailsController = BehaviorSubject<UserModel>();

  // Streams
  Observable<bool> get isAuthenticatedStream =>
      _isAuthenticatedController.stream;

  Observable<bool> get isLogingStream => _isLogingController.stream;

  Observable<bool> get isFetchingAccountDetailsStream =>
      _isFetchingAccountDetailsController.stream;

  Observable<UserModel> get fetchAccountDetailsStream =>
      _accountDetailsController.stream;

  /* Functions */
  void login(String login, String password) async {
    logger.info('login');
    if (!_isLogingController.value) {
      _isLogingController.add(true);

      await apiService
          .login(AuthLoginModel(login: login, password: password))
          .then((AuthLoginResponseModel response) {
        if (response.error == false) {
          if (response.token != null) {
            // TODO : Fix Save Auth in Shared prefs
            SharedPreferencesService.setAuthToken(response.token);
            SharedPreferencesService.setAuthConnected(true);
            _isAuthenticatedController.add(true);
          }
          _accountDetailsController.add(response.user);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_accountDetailsController.addError);

      _isLogingController.add(false);
    }
  }

  void logout() async {
    logger.info('Logout');
    if (!_isLogingController.value) {
      _isLogingController.add(true);

      await SharedPreferencesService.deleteAuthToken();
      await SharedPreferencesService.deleteAuthConnected();
      _accountDetailsController.add(null);
      _isAuthenticatedController.add(false);

      _isLogingController.add(false);
    }
  }

  void fetchAccountDetails() async {
    logger.info('fetchAccountDetails');
    if (!_isFetchingAccountDetailsController.value) {
      _isFetchingAccountDetailsController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then(apiService.fetchAccountDetails)
          .then((ResponseModel<UserModel> response) {
        if (response.error == false) {
          _accountDetailsController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_accountDetailsController.addError);

      _isFetchingAccountDetailsController.add(false);
    }
  }

  @override
  void dispose() {
    _isAuthenticatedController.close();
    _isLogingController.close();
    _isFetchingAccountDetailsController.close();
    _accountDetailsController.close();
  }
}
