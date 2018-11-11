import 'package:cv/src/blocs/bloc_provider.dart';
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
  final _fetchAccountDetailsController =
      BehaviorSubject<ResponseModel<UserModel>>();
  final _connectionController = BehaviorSubject<AuthLoginResponseModel>();
  final _isAuthenticatedController = BehaviorSubject<bool>();
  final _isLogingController = BehaviorSubject<bool>();
  final _isFetchingController = BehaviorSubject<bool>();

  // Streams
  Observable<ResponseModel<UserModel>> get fetchAccountDetailsStream =>
      _fetchAccountDetailsController.stream;

  Observable<AuthLoginResponseModel> get connectionStream =>
      _connectionController.stream;

  Observable<bool> get isAuthenticatedStream =>
      _isAuthenticatedController.stream;

  Observable<bool> get isLogingStream => _isLogingController.stream;

  Observable<bool> get isFetchingStream => _isFetchingController.stream;

  /* Functions */
  void login(String login, String password) async {
    if (!_isLogingController.value) {
      _isLogingController.add(true);

      AuthLoginResponseModel loginResponseModel = await apiService
          .login(AuthLoginModel(login: login, password: password));

      _connectionController.add(loginResponseModel);

      if (!loginResponseModel.error && loginResponseModel.token.isNotEmpty) {
        SharedPreferencesService.setAuthToken(loginResponseModel.token);
        SharedPreferencesService.setAuthConnected(true);
        _isAuthenticatedController.add(true);
      }

      _isLogingController.add(false);
    }
  }

  void logout() async {
    print('Logout');
    if (!_isLogingController.value) {
      _isLogingController.add(true);
      await SharedPreferencesService.deleteAuthToken();
      await SharedPreferencesService.deleteAuthConnected();
      _connectionController.add(null);
      _isAuthenticatedController.add(false);
      _isLogingController.add(false);
    }
  }

  void fetchAccountDetails() async {
    if (!_isFetchingController.value) {
      _isFetchingController.add(true);

      SharedPreferencesService.getAuthToken()
          .then(apiService.fetchAccountDetails)
          .then(_fetchAccountDetailsController.add);

      _isFetchingController.add(false);
    }
  }

  @override
  void dispose() {
    _connectionController.close();
    _isAuthenticatedController.close();
    _fetchAccountDetailsController.close();
    _isLogingController.close();
    _isFetchingController.close();
  }
}
