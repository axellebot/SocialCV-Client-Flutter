import 'package:cv/src/blocs/account_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/login_bloc.dart';
import 'package:cv/src/blocs/validators.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc loginBloc;

  _LoginPageState() {
    loginBloc = LoginBloc();
  }

  @override
  Widget build(BuildContext context) {
    print('Building LoginPage');
    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(Localization.of(context).loginTitle),
      centerTitle: true,
    );
  }

  Widget _buildBody(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return SafeArea(
      child: Stack(
        children: <Widget>[
          _buildProgressBar(context),
          ListView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            children: <Widget>[
              SizedBox(height: 40.0),
              Column(
                children: <Widget>[
                  Image.asset('images/account_card_details-blue.png'),
                  SizedBox(height: 16.0),
                  Text(
                    Localization.of(context).appName,
                    style: Theme.of(context).textTheme.title,
                  ),
                ],
              ),
              const SizedBox(height: 120.0),
              _buildEmailInput(),
              const SizedBox(height: 12.0),
              _buildPasswordInput(),
              const SizedBox(height: 12.0),
              _buildMessageLabel(context),
              ButtonBar(
                children: <Widget>[
                  RaisedButton(
                    child: Text(Localization.of(context).loginSignUpCTA),
                    onPressed: () => _handleNotImplementedYet(context),
                  ),
                  StreamBuilder<bool>(
                    initialData: false,
                    stream: loginBloc.submitLoginStream,
                    builder:
                        (BuildContext context, AsyncSnapshot<bool> snapshot) {
                      return RaisedButton(
                          child: Text(Localization.of(context).loginSignInCTA),
                          onPressed: (snapshot.hasData && snapshot.data)
                              ? () => _accountBloc.login(
                                  loginBloc.emailValue, loginBloc.passwordValue)
                              : null);
                    },
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 2.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 16.0)),
                  Text(
                    Localization.of(context).loginOr,
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const Padding(padding: EdgeInsets.only(left: 16.0)),
                  Expanded(
                    child: Container(
                      height: 2.0,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 25.0)),
              Center(
                child: RaisedButton(
                  onPressed: () => _handleNotImplementedYet(context),
                  child: Text(Localization.of(context).loginSignInGoogleCTA),
                ),
              ),
              const Padding(padding: EdgeInsets.only(top: 16.0)),
              Center(
                child: RaisedButton(
                  onPressed: () => _handleNotImplementedYet(context),
                  child: Text(Localization.of(context).loginSignInFacebookCTA),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<bool>(
      stream: _accountBloc.isLogingStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return LinearProgressIndicator();
        }
        return Container();
      },
    );
  }

  Widget _buildEmailInput() {
    return StreamBuilder(
      stream: loginBloc.emailStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        String error;
        if (snapshot.hasError) {
          ValidationErrors errorType = snapshot.error;
          if (errorType == ValidationErrors.ERROR_LOGIN_NO_EMAIL) {
            error = Localization.of(context).loginNoEmailExplain;
          } else if (errorType == ValidationErrors.ERROR_LOGIN_NOT_EMAIL) {
            error = Localization.of(context).loginNotEmailExplain;
          }
        }
        return TextField(
          onChanged: loginBloc.changeEmail,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            labelText: Localization.of(context).email + ' *',
            hintText: 'username@example.com',
            errorText: error,
          ),
        );
      },
    );
  }

  Widget _buildPasswordInput() {
    return StreamBuilder(
      stream: loginBloc.passwordStream,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        String error;
        if (snapshot.hasError) {
          ValidationErrors errorType = snapshot.error;
          if (errorType == ValidationErrors.ERROR_LOGIN_NO_PASSWORD) {
            error = Localization.of(context).loginNoPasswordExplain;
          }
        }
        return TextField(
          onChanged: loginBloc.changePassword,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              labelText: Localization.of(context).password + ' *',
              errorText: error,
              suffixIcon: GestureDetector(
                onTap: loginBloc.toggleObscure,
                child: Icon(loginBloc.obscureValue
                    ? Icons.visibility
                    : Icons.visibility_off),
              )),
          obscureText: loginBloc.obscureValue,
        );
      },
    );
  }

  Widget _buildMessageLabel(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<UserModel>(
      stream: _accountBloc.fetchAccountDetailsStream,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasError) {
          return Text(translateError(context, snapshot.error));
        } else if (snapshot.hasData) {
          return Text('Hello ${snapshot.data.username}');
        }
        return Container();
      },
    );
  }

  void _handleNotImplementedYet(BuildContext context) {
//    Scaffold.of(context).showSnackBar(SnackBar(
//      content: Text('Not implemented yet !'),
//    ));
  }
}
