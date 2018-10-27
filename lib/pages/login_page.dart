import 'dart:async';

import 'package:cv/localizations/localization.dart';
import 'package:cv/widgets/password_form_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(value)));
  }

  bool _autovalidate = false;
  bool _formWasEdited = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordFieldKey =
      GlobalKey<FormFieldState<String>>();

  void _handleSubmitted() {
    final FormState form = _formKey.currentState;
    if (!form.validate()) {
      _autovalidate = true; // Start validating on every change.
      showInSnackBar('Please fix the errors in red before submitting.');
    } else {
      form.save();
      showInSnackBar(Localization.of(context).logged);
    }
  }

  void _handleSignUp() {
    showInSnackBar('Not implemented yet !');
  }

  String _validateEmail(String value) {
    _formWasEdited = true;
    if (value.isEmpty) return Localization.of(context).loginNoEmailTitle;
    final RegExp nameExp =
        RegExp(r'^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)\.([a-zA-Z]{2,5})$');
    if (!nameExp.hasMatch(value))
      return Localization.of(context).loginNotEmailExplain;
    return null;
  }

  String _validatePassword(String value) {
    _formWasEdited = true;
    if (value.isEmpty) return Localization.of(context).loginNoPasswordTitle;
    return null;
  }

  Future<bool> _warnUserAboutInvalidData() async {
    final FormState form = _formKey.currentState;
    if (form == null || !_formWasEdited) return true;

    return await showDialog<bool>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('This form has been filled'),
              content: const Text('Really leave this form?'),
              actions: <Widget>[
                FlatButton(
                  child: Text(Localization.of(context).yes),
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                ),
                FlatButton(
                  child: Text(Localization.of(context).no),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
              ],
            );
          },
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      body: ListView(
        children: <Widget>[
          Form(
            key: _formKey,
            autovalidate: _autovalidate,
            onWillPop: _warnUserAboutInvalidData,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  SizedBox(height: 80.0),
                  Column(
                    children: <Widget>[
                      Image.asset('images/account_card_details-blue.png'),
                      SizedBox(height: 16.0),
                      Text(
                        Localization.of(context).appName,
                        style: Theme.of(context).textTheme.headline,
                      ),
                    ],
                  ),
                  const SizedBox(height: 120.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    decoration: InputDecoration(
                      hintText: 'username@example.com',
                      labelText: Localization.of(context).email + ' *',
                    ),
                    maxLines: 1,
                  ),
                  const SizedBox(height: 12.0),
                  PasswordFormField(
                    fieldKey: _passwordFieldKey,
                    validator: _validatePassword,
                    labelText: Localization.of(context).password + ' *',
                  ),
                  ButtonBar(
                    children: <Widget>[
                      RaisedButton(
                        child: Text(Localization.of(context).loginSignUp),
                        onPressed: _handleSignUp,
                      ),
                      RaisedButton(
                        child: Text(Localization.of(context).loginSignIn),
                        onPressed: _handleSubmitted,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Container(
                  height: 2.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context).textTheme.title.color,
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
                    color: Theme.of(context).textTheme.title.color,
                  ),
                ),
              ),
            ],
          ),
          const Padding(padding: EdgeInsets.only(top: 25.0)),
          Center(
            child: RaisedButton(
              onPressed: () {},
              child: Text(Localization.of(context).loginSignInGoogleCTA),
            ),
          ),
          const Padding(padding: EdgeInsets.only(top: 16.0)),
          Center(
            child: RaisedButton(
              onPressed: () {},
              child: Text(Localization.of(context).loginSignInFacebookCTA),
            ),
          ),
        ],
      ),
    );
  }
}
