import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final String _tag = '$_LoginFormState';

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

  bool _obscureTextLogin = true;

  @override
  void dispose() {
    print('$_tag:dispose()');
    loginEmailController.dispose();
    loginPasswordController.dispose();
    myFocusNodeEmailLogin.dispose();
    myFocusNodePasswordLogin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('$_tag:build');
    final LoginBloc _loginBloc = BlocProvider.of<LoginBloc>(context);

    void _loginPressed() {
      _loginBloc.add(LoginButtonPressed(
        email: loginEmailController.text,
        password: loginPasswordController.text,
      ));
    }

    return BlocListener<LoginBloc, LoginState>(
      bloc: _loginBloc,
      listener: (BuildContext context, LoginState state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppStyles.errorColor,
              content: ErrorRow(error: state.error),
            ),
          );
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        bloc: _loginBloc,
        builder: (BuildContext context, LoginState state) {
          return Card(
            elevation: AppStyles.defaultCardElevation,
            child: Padding(
              padding: AppStyles.defaultCardPadding,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Text(CVLocalizations.of(context)!.authLoginTitle),
                  ),
                  Padding(
                    padding: AppStyles.defaultFormInputPadding,
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                      controller: loginEmailController,
                      decoration: InputDecoration(
                        hintText: CVLocalizations.of(context)!.formEmailHint,
                        labelText: CVLocalizations.of(context)!.formEmailLabel,
                      ),
                    ),
                  ),
                  Padding(
                    padding: AppStyles.defaultFormInputPadding,
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
                        labelText:
                            CVLocalizations.of(context)!.formPasswordLabel,
                      ),
                    ),
                  ),
                  MaterialButton(
                    child: Text(CVLocalizations.of(context)!.authLoginCTA),
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
