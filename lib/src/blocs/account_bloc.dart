import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/services/cv_api_service.dart';
import 'package:cv/src/services/secret_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:rxdart/rxdart.dart';

class AccountBloc extends BlocBase {
  AccountBloc() : super() {
    _isAuthenticatedController.add(false);
    _isLogingController.add(false);
    _isFetchingAccountDetailsController.add(false);
  }

  CVApiService apiService = CVApiService();

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
  void login(String username, String password) async {
    logger.info('login');
    if (!_isLogingController.value) {
      _isLogingController.add(true);

      Secret secret = await SecretService.load();

      await apiService
          .fetchToken(
        oauthTokenModel: OAuthTokenModel(
          username: username,
          password: password,
          clientId: secret.clientId,
          clientSecret: secret.clientSecret,
          grantType: "password",
        ),
      )
          .then((OAuthAccessTokenResponseModel response) {
        if (response != null) {
          if (response.accessToken != null) {
            SharedPreferencesService.setAccessToken(response.accessToken);
            SharedPreferencesService.setAccessTokenExpiration(
                response.accessTokenExpiresAt);
            SharedPreferencesService.setRefreshToken(response.refreshToken);
            SharedPreferencesService.setAuthConnected(true);
            _isAuthenticatedController.add(true);
            this.fetchAccountDetails();
          }
        } else {
          throw Exception();
        }
      }).catchError((err) {
        _accountDetailsController.addError(err);
      });

      _isLogingController.add(false);
    }
  }

  void logout() async {
    logger.info('logout');
    if (!_isLogingController.value) {
      _isLogingController.add(true);

      await SharedPreferencesService.deleteAccessToken();
      await SharedPreferencesService.deleteAccessTokenExpiration();
      await SharedPreferencesService.deleteRefreshToken();
      await SharedPreferencesService.deleteRefreshTokenExpiration();
      await SharedPreferencesService.deleteUserId();

      _accountDetailsController.add(null);
      _isAuthenticatedController.add(false);

      _isLogingController.add(false);
    }
  }

  void fetchAccountDetails() async {
    logger.info('fetchAccountDetails');
    if (!_isFetchingAccountDetailsController.value) {
      _isFetchingAccountDetailsController.add(true);

      String accessToken = await SharedPreferencesService.getAccessToken();

      await apiService
          .fetchAccountDetails(accessToken: accessToken)
          .then((ResponseModel<UserModel> response) {
        if (response.error == false) {
          SharedPreferencesService.setUserId(response.data.id);
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
