import 'package:cv/src/blocs/auth_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/validators.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/auth_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _passwordObscured = true;
  AuthBloc loginBloc;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  void _handleNotImplementedYet() {
    _showInSnackBar('Not implemented yet !');
  }

  void _navigateToMain() {
    Navigator.of(context).pushNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    print('build');
    loginBloc = BlocProvider.of<AuthBloc>(context);
    return new Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: loginBloc.isWorkingStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return LinearProgressIndicator();
              }
              return Container();
            },
          ),
          SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                StreamBuilder(
                  stream: loginBloc.emailStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    String error;
                    if (snapshot.hasError) {
                      ValidationErrors errorType = snapshot.error;
                      if (errorType == ValidationErrors.ERROR_LOGIN_NO_EMAIL) {
                        error = Localization.of(context).loginNoEmailExplain;
                      } else if (errorType ==
                          ValidationErrors.ERROR_LOGIN_NOT_EMAIL) {
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
                ),
                const SizedBox(height: 12.0),
                StreamBuilder(
                  stream: loginBloc.passwordStream,
                  builder:
                      (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                    String error;
                    if (snapshot.hasError) {
                      ValidationErrors errorType = snapshot.error;
                      if (errorType ==
                          ValidationErrors.ERROR_LOGIN_NO_PASSWORD) {
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
                            onTap: () {
                              setState(() {
                                _passwordObscured = !_passwordObscured;
                              });
                            },
                            child: Icon(_passwordObscured
                                ? Icons.visibility
                                : Icons.visibility_off),
                          )),
                      obscureText: _passwordObscured,
                    );
                  },
                ),
                StreamBuilder<AuthLoginResponseModel>(
                  stream: loginBloc.connectionStream,
                  builder: (BuildContext context,
                      AsyncSnapshot<AuthLoginResponseModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.error) {
                        return Text(snapshot.data.message);
                      } else {
                        return Text('Hello ${snapshot.data.user.username}');
                      }
                    }
                    return Container();
                  },
                ),
                ButtonBar(
                  children: <Widget>[
                    RaisedButton(
                      child: Text(Localization.of(context).loginSignUpCTA),
                      onPressed: _handleNotImplementedYet,
                    ),
                    StreamBuilder<bool>(
                      initialData: false,
                      stream: loginBloc.submitLoginStream,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return RaisedButton(
                          child: Text(Localization.of(context).loginSignInCTA),
                          onPressed: snapshot.hasData && snapshot.data
                              ? loginBloc.login
                              : null,
                        );
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
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontFamily: "Google Sans",
                      ),
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
                    onPressed: _handleNotImplementedYet,
                    child: Text(Localization.of(context).loginSignInGoogleCTA),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 16.0)),
                Center(
                  child: RaisedButton(
                    onPressed: _handleNotImplementedYet,
                    child:
                        Text(Localization.of(context).loginSignInFacebookCTA),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text(Localization.of(context).loginTitle),
      centerTitle: true,
    );
  }
}
