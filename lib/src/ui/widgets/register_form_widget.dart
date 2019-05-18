import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/repositories.dart';
import 'package:social_cv_client_flutter/src/ui/commons/colors.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';

class RegisterFormWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegisterFormWidgetState();
}

class _RegisterFormWidgetState extends State<RegisterFormWidget> {
  final FocusNode myFocusNodePassword = FocusNode();
  final FocusNode myFocusNodeEmail = FocusNode();
  final FocusNode myFocusNodeFirstName = FocusNode();
  final FocusNode myFocusNodeLastName = FocusNode();

  bool _obscureTextSignup = true;
  bool _obscureTextSignupConfirm = true;

  TextEditingController signupEmailController = new TextEditingController();
  TextEditingController signupFisrtNameController = new TextEditingController();
  TextEditingController signupLastNameController = new TextEditingController();
  TextEditingController signupPasswordController = new TextEditingController();
  TextEditingController signupConfirmPasswordController =
      new TextEditingController();

  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();

    final authBloc = BlocProvider.of<AuthenticationBloc>(context);
    final cvRepository = Provider.of<CVRepository>(context);

    _registerBloc = RegisterBloc(
      cvRepository: cvRepository,
      authenticationBloc: authBloc,
    );
  }

  @override
  void dispose() {
    myFocusNodeFirstName?.dispose();
    myFocusNodeEmail?.dispose();
    myFocusNodePassword?.dispose();
    _registerBloc?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterEvent, RegisterState>(
        bloc: _registerBloc,
        builder: (BuildContext context, RegisterState state) {
          Container(
            padding: EdgeInsets.only(top: 23.0),
            child: Column(
              children: <Widget>[
                Stack(
                  alignment: Alignment.topCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    Card(
                      elevation: 2.0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        width: 300.0,
                        height: 360.0,
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextField(
                                focusNode: myFocusNodeFirstName,
                                controller: signupFisrtNameController,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    MdiIcons.account,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Firstname',
                                  hintStyle: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextField(
                                focusNode: myFocusNodeFirstName,
                                controller: signupLastNameController,
                                keyboardType: TextInputType.text,
                                textCapitalization: TextCapitalization.words,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    MdiIcons.account,
                                    color: Colors.black,
                                  ),
                                  hintText: 'Lastname',
                                  hintStyle: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextField(
                                focusNode: myFocusNodeEmail,
                                controller: signupEmailController,
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    MdiIcons.email,
                                    color: Colors.black,
                                  ),
                                  hintText: CVLocalizations.of(context).email,
                                  hintStyle: TextStyle(fontSize: 16.0),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextField(
                                focusNode: myFocusNodePassword,
                                controller: signupPasswordController,
                                obscureText: _obscureTextSignup,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    MdiIcons.lock,
                                    color: Colors.black,
                                  ),
                                  hintText:
                                      CVLocalizations.of(context).password,
                                  hintStyle: TextStyle(fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleSignup,
                                    child: Icon(
                                      MdiIcons.eye,
                                      size: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 250.0,
                              height: 1.0,
                              color: Colors.grey[400],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 20.0,
                                  bottom: 20.0,
                                  left: 25.0,
                                  right: 25.0),
                              child: TextField(
                                controller: signupConfirmPasswordController,
                                obscureText: _obscureTextSignupConfirm,
                                style: TextStyle(
                                    fontSize: 16.0, color: Colors.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  icon: Icon(
                                    MdiIcons.lock,
                                    color: Colors.black,
                                  ),
                                  hintText: CVLocalizations.of(context)
                                      .passwordRepeat,
                                  hintStyle: TextStyle(fontSize: 16.0),
                                  suffixIcon: GestureDetector(
                                    onTap: _toggleSignupConfirm,
                                    child: Icon(
                                      MdiIcons.eye,
                                      size: 15.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 340.0),
                      decoration: new BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: AppColors.loginGradientStart,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                          BoxShadow(
                            color: AppColors.loginGradientEnd,
                            offset: Offset(1.0, 6.0),
                            blurRadius: 20.0,
                          ),
                        ],
                        gradient: new LinearGradient(
                            colors: [
                              AppColors.loginGradientEnd,
                              AppColors.loginGradientStart
                            ],
                            begin: const FractionalOffset(0.2, 0.2),
                            end: const FractionalOffset(1.0, 1.0),
                            stops: [0.0, 1.0],
                            tileMode: TileMode.clamp),
                      ),
                      child: MaterialButton(
                        highlightColor: Colors.transparent,
                        splashColor: AppColors.loginGradientEnd,
                        //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 42.0),
                          child: Text(
                            CVLocalizations.of(context).authSignUpCTA,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                        onPressed: state is! RegisterLoading
                            ? _onRegisterButtonPressed
                            : null,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  void _toggleSignup() {
    setState(() {
      _obscureTextSignup = !_obscureTextSignup;
    });
  }

  void _toggleSignupConfirm() {
    setState(() {
      _obscureTextSignupConfirm = !_obscureTextSignupConfirm;
    });
  }

  _onRegisterButtonPressed() {
    _registerBloc.dispatch(RegisterButtonPressed(
      fName: signupFisrtNameController.text,
      lName: signupLastNameController.text,
      email: signupEmailController.text,
      password: signupPasswordController.text,
    ));
  }
}
