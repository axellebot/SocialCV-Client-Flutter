import 'package:rxdart/rxdart.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/utils/validators.dart';

const String _TAG = "LoginBloc";

class LoginBloc extends BlocBase with Validators {
  LoginBloc() : super();

  // Reactive variables
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _connectionController =
      BehaviorSubject<OAuthAccessTokenResponseModel>();

  bool _obscureValue = true;

  // Streams
  Observable<String> get emailStream =>
      _emailController.stream.transform(validateEmail);

  // Causing usable when stream closed (on bloc disposed)

  Observable<String> get passwordStream =>
      _passwordController.stream.transform(validatePassword);

  // Causing usable when stream closed (on bloc disposed)

  Observable<bool> get submitLoginStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) {
        print('PerformSubmitValidation $e $p');
        return true;
      });

  // Sinks
  Sink<String> get email => _emailController.sink;

  Sink<String> get password => _passwordController.sink;

  /* Functions */
  // Human functions
  Function(String) get changeEmail => email.add;

  Function(String) get changePassword => password.add;

  bool get obscureValue => _obscureValue;

  String get emailValue => _emailController.value;

  String get passwordValue => _passwordController.value;

  void toggleObscure() {
    _obscureValue = !obscureValue;
    _passwordController.add(passwordValue);
  }

  @override
  dispose() {
    _emailController.close();
    _passwordController.close();
    _connectionController.close();
  }
}
