import 'package:cv/src/blocs/auth_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/validators.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/auth_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  LoginPage() : super();

  final bool _passwordObscured = true;

  @override
  Widget build(BuildContext context) {
    print('Building LoginPage');
    return new Scaffold(
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
    AuthBloc _loginBloc = BlocProvider.of<AuthBloc>(context);
    return SafeArea(
      child: Stack(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: _loginBloc.isWorkingStream,
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
                  stream: _loginBloc.emailStream,
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
                      onChanged: _loginBloc.changeEmail,
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
                  stream: _loginBloc.passwordStream,
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
                      onChanged: _loginBloc.changePassword,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: Localization.of(context).password + ' *',
                          errorText: error,
                          suffixIcon: GestureDetector(
                            onTap: () {
//                              setState(() {
//                                _passwordObscured = !_passwordObscured;
//                              });
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
                  stream: _loginBloc.connectionStream,
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
                      onPressed: () => _handleNotImplementedYet(context),
                    ),
                    StreamBuilder<bool>(
                      initialData: false,
                      stream: _loginBloc.submitLoginStream,
                      builder:
                          (BuildContext context, AsyncSnapshot<bool> snapshot) {
                        return RaisedButton(
                          child: Text(Localization.of(context).loginSignInCTA),
                          onPressed: snapshot.hasData && snapshot.data
                              ? _loginBloc.login
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
                    onPressed: () => _handleNotImplementedYet(context),
                    child: Text(Localization.of(context).loginSignInGoogleCTA),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 16.0)),
                Center(
                  child: RaisedButton(
                    onPressed: () => _handleNotImplementedYet(context),
                    child:
                        Text(Localization.of(context).loginSignInFacebookCTA),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _handleNotImplementedYet(BuildContext context) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('Not implemented yet !'),
    ));
  }
}
