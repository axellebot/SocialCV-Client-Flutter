import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/validators.dart';
import 'package:cv/src/models/auth_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:cv/src/services/shared_preferences_service.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends BlocBase with Validators {
  AuthBloc() : super() {
    _isAuthenticatedController.add(false);
    _isWorkingController.add(false);
  }

  ApiService apiService = ApiService();

  // Reactive variables
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _connectionController = BehaviorSubject<AuthLoginResponseModel>();
  final _isAuthenticatedController = BehaviorSubject<bool>();
  final _isWorkingController = BehaviorSubject<bool>();

  // Streams
  Observable<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  Observable<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  Observable<bool> get submitLoginStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) {
        print('PerformSubmitValidation $e $p');
        return true;
      });

  Observable<AuthLoginResponseModel> get connectionStream =>
      _connectionController.stream;

  Observable<bool> get isAuthenticatedStream =>
      _isAuthenticatedController.stream;

  Observable<bool> get isWorkingStream => _isWorkingController.stream;

  // Sinks
  Sink<String> get email => _emailController.sink;

  Sink<String> get password => _passwordController.sink;

  /* Functions */

  // Human functions
  Function(String) get changeEmail => email.add;

  Function(String) get changePassword => password.add;

  login() async {
    if (!_isWorkingController.value) {
      _isWorkingController.add(true);

      final validEmail = _emailController.value;
      final validPassword = _passwordController.value;

      AuthLoginResponseModel loginResponseModel = await apiService
          .login(AuthLoginModel(login: validEmail, password: validPassword));

      _connectionController.add(loginResponseModel);

      if (!loginResponseModel.error && loginResponseModel.token.isNotEmpty) {
        SharedPreferencesService.setAuthToken(loginResponseModel.token);
        SharedPreferencesService.setAuthConnected(true);
        _isAuthenticatedController.add(true);
      }

      _isWorkingController.add(false);
    }
  }

  logout() async {
    if (!_isWorkingController.value) {
      _isWorkingController.add(true);
      await SharedPreferencesService.deleteAuthToken();
      await SharedPreferencesService.deleteAuthConnected();
      _connectionController.add(null);
      _isAuthenticatedController.add(false);
      _isWorkingController.add(false);
    }
  }

  @override
  dispose() {
    _emailController.close();
    _passwordController.close();
    _connectionController.close();
    _isAuthenticatedController.close();
    _isWorkingController.close();
  }
}
