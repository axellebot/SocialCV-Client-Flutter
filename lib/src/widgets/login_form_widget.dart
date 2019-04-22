import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/commons/colors.dart';
import 'package:social_cv_client_flutter/src/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';
import 'package:social_cv_client_flutter/src/widgets/error_widget.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  static const _TAG = '_LoginFormWidgetState';

  _LoginFormWidgetState();

  final FocusNode myFocusNodeEmailLogin = FocusNode();
  final FocusNode myFocusNodePasswordLogin = FocusNode();

  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();

  bool _obscureTextLogin = true;

  String errorText;

  @override
  Widget build(BuildContext context) {
    logger.info('$_TAG:build');

    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return Container(
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
                  height: 190.0,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodeEmailLogin,
                          controller: loginEmailController,
                          keyboardType: TextInputType.emailAddress,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              MdiIcons.email,
                              color: Colors.black,
                              size: 22.0,
                            ),
                            hintText: CVLocalizations.of(context).email,
                            hintStyle: TextStyle(fontSize: 17.0),
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
                            top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
                        child: TextField(
                          focusNode: myFocusNodePasswordLogin,
                          controller: loginPasswordController,
                          obscureText: _obscureTextLogin,
                          style: TextStyle(fontSize: 16.0, color: Colors.black),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            icon: Icon(
                              MdiIcons.lock,
                              size: 22.0,
                              color: Colors.black,
                            ),
                            hintText: CVLocalizations.of(context).password,
                            hintStyle: TextStyle(fontSize: 17.0),
                            suffixIcon: GestureDetector(
                              onTap: _toggleLogin,
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
                margin: EdgeInsets.only(top: 170.0),
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
                      CVLocalizations.of(context).authSignInCTA,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  onPressed: () => _accountBloc.login(
                      loginEmailController.text, loginPasswordController.text),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: FlatButton(
                onPressed: () {},
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white10,
                          Colors.white,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Text(
                    'Or',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16.0,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: new LinearGradient(
                        colors: [
                          Colors.white,
                          Colors.white10,
                        ],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 1.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp),
                  ),
                  width: 100.0,
                  height: 1.0,
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0, right: 40.0),
                child: GestureDetector(
                  onTap: () => print('Facebook button pressed'),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      MdiIcons.facebook,
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: GestureDetector(
                  onTap: () => print('Google button pressed'),
                  child: Container(
                    padding: const EdgeInsets.all(15.0),
                    decoration: new BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: new Icon(
                      MdiIcons.google,
                      color: Color(0xFF0084ff),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    myFocusNodeEmailLogin.dispose();
    myFocusNodePasswordLogin.dispose();
    super.dispose();
  }

  void _toggleLogin() {
    setState(() {
      _obscureTextLogin = !_obscureTextLogin;
    });
  }
}

class _LoginFromMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);
    return StreamBuilder<UserModel>(
      stream: _accountBloc.accountDetailsStream,
      builder: (BuildContext context, AsyncSnapshot<UserModel> snapshot) {
        if (snapshot.hasError) {
          return ErrorCard(message: translateError(context, snapshot.error));
        } else if (snapshot.hasData) {
          return Card(
            child: Container(
              padding: EdgeInsets.all(10.0),
              child: Text('Hello ${snapshot.data.username}'),
            ),
          );
        }
        return Container();
      },
    );
  }
}
