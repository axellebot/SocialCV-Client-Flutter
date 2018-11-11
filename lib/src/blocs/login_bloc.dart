import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/validators.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends BlocBase with Validators {
  LoginBloc() : super();

  // Reactive variables
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _connectionController = BehaviorSubject<AuthLoginResponseModel>();

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

  // Sinks
  Sink<String> get email => _emailController.sink;

  Sink<String> get password => _passwordController.sink;

  /* Functions */
  // Human functions
  Function(String) get changeEmail => email.add;

  Function(String) get changePassword => password.add;

  String get emailValue => _emailController.value;

  String get passwordValue => _passwordController.value;

  @override
  dispose() {
    _emailController.close();
    _passwordController.close();
    _connectionController.close();
  }
}
