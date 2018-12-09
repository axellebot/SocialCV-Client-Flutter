import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/commons/logger.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

class AccountBloc extends BlocBase {
  AccountBloc() : super() {
    _isAuthenticatedController.add(false);
    _isLogingController.add(false);
    _isFetchingController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _accountDetailsController = BehaviorSubject<UserModel>();
  final _isAuthenticatedController = BehaviorSubject<bool>();
  final _isLogingController = BehaviorSubject<bool>();
  final _isFetchingController = BehaviorSubject<bool>();

  // Streams
  Observable<UserModel> get fetchAccountDetailsStream =>
      _accountDetailsController.stream;

  Observable<bool> get isAuthenticatedStream =>
      _isAuthenticatedController.stream;

  Observable<bool> get isLogingStream => _isLogingController.stream;

  Observable<bool> get isFetchingStream => _isFetchingController.stream;

  /* Functions */
  void login(String login, String password) async {
    logger.info('Login');
    if (!_isLogingController.value) {
      _isLogingController.add(true);

      await apiService
          .login(AuthLoginModel(login: login, password: password))
          .then((AuthLoginResponseModel response) {
        if (response.error == false) {
          if (response.token != null) {
            SharedPreferencesService.setAuthToken(response.token);
            SharedPreferencesService.setAuthConnected(true);
            _isAuthenticatedController.add(true);
          }
          return _accountDetailsController.add(response.user);
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
    if (!_isFetchingController.value) {
      _isFetchingController.add(true);

      await SharedPreferencesService.getAuthToken()
          .then(apiService.fetchAccountDetails)
          .then((ResponseModel<UserModel> response) {
        if (response.error == false) {
          return _accountDetailsController.add(response.data);
        } else {
          throw Exception(response.message);
        }
      }).catchError(_accountDetailsController.addError);

      _isFetchingController.add(false);
    }
  }

  @override
  void dispose() {
    _isAuthenticatedController.close();
    _accountDetailsController.close();
    _isLogingController.close();
    _isFetchingController.close();
  }
}
