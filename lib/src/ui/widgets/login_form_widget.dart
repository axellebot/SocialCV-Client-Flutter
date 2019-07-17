import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/ui/commons/colors.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final String _tag = '$_LoginFormState';

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;

  @override
  void dispose() {
    print('$_tag:$dispose()');
    loginEmailController.dispose();
    loginPasswordController.dispose();
    myFocusNodeEmailLogin.dispose();
    myFocusNodePasswordLogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('$_tag:$build');
    LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    void _loginPressed() {
      _loginBloc.dispatch(LoginButtonPressed(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      ));
    }

    return BlocListener<LoginEvent, LoginState>(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.errorColor,
              content: Text('${state.error.runtimeType}'),
            ),
          );
        }
      },
      child: BlocBuilder<LoginEvent, LoginState>(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Card(
            elevation: AppDimensions.defaultCardElevation,
            child: Padding(
              padding: EdgeInsets.all(AppDimensions.defaultCardPadding),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: Text('Login')),
                  Padding(
                    padding: const EdgeInsets.all(
                        AppDimensions.defaultFormInputPadding),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: loginEmailController,
                      decoration: InputDecoration(
                        hintText: 'someone@email.com',
                        labelText: 'Email',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        AppDimensions.defaultFormInputPadding),
                    child: TextFormField(
                      controller: loginPasswordController,
                      obscureText: _obscureTextLogin,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          icon: Icon(_obscureTextLogin
                              ? MdiIcons.eyeOffOutline
                              : MdiIcons.eyeOutline),
                          onPressed: _toggleLoginPassword,
                        ),
                        labelText: 'Password',
                      ),
                    ),
                  ),
                  MaterialButton(
                    child: Text('LOGIN'),
                    onPressed: state is! LoginLoading ? _loginPressed : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _toggleLoginPassword() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
}
