import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/validators.dart';
import 'package:cv/src/models/login_model.dart';
import 'package:cv/src/services/api_service.dart';
import 'package:rxdart/rxdart.dart';

class AuthBloc extends BlocBase with Validators {
  ApiService apiProvider = ApiService();

  AuthBloc() : super();

  // Reactive variables
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();

  final _tokenFetcher = PublishSubject<LoginResponseModel>();

  // Streams
  Observable<String> get emailStream =>
      _emailController.stream.transform(performEmailValidation(context));

  Observable<String> get passwordStream =>
      _passwordController.stream.transform(performPasswordValidation(context));

  Observable<bool> get submitLoginStream =>
      Observable.combineLatest2(emailStream, passwordStream, (e, p) {
        print('PerformSubmitValidation $e $p');
        return true;
      });

  Observable<LoginResponseModel> get tokenStream => _tokenFetcher.stream;

  // Sinks
  Function(String) get changeEmail => _emailController.sink.add;

  Function(String) get changePassword => _passwordController.sink.add;

  submit() async {
    final validEmail = _emailController.value;
    final validPassword = _passwordController.value;
    print('Submit $validEmail and $validPassword');

    LoginResponseModel loginResponseModel =
        await apiProvider.login(LoginModel(validEmail, validPassword));

    print('Token $loginResponseModel');
    _tokenFetcher.sink.add(loginResponseModel);
  }

  dispose() {
    _emailController.close();
    _passwordController.close();
    _tokenFetcher.close();
  }
}
