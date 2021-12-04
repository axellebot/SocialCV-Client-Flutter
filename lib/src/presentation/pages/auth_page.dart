import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final String _tag = '$_AuthPageState';

  // Variable
  double? screenWidth;
  double? screenHeight;

  PageController? _pageController;

  Color left = Colors.black;
  Color right = Colors.white;

  // Business
  @override
  void initState() {
    print('$_tag:initState()');
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    print('$_tag:dispose()');
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('$_tag:build');
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    screenHeight = (screenHeight! > AppStyles.authPageMinHeight)
        ? screenHeight
        : AppStyles.authPageMinHeight;

    return Scaffold(
      backgroundColor: AppStyles.primaryColor,
      body: MultiBlocListener(
        listeners: <BlocListener>[
          BlocListener<AuthenticationBloc, AuthenticationState>(
            bloc: BlocProvider.of<AuthenticationBloc>(context),
            listener: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationAuthenticated) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppStyles.successColor,
                  content: Text(CVLocalizations.of(context)!.authLoginSucceed),
                ));
                Future.delayed(const Duration(seconds: 1))
                    .then((_) => Navigator.of(context).pop());
              }
            },
          ),
        ],
        child: SingleChildScrollView(
          child: Container(
            height: screenHeight,
            child: Stack(
              children: <Widget>[
                _buildHeaderSection(context),
                _buildAuthSection(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderSection(BuildContext context) {
    return Container(
      height: screenHeight! * 0.25,
      width: screenWidth,
    );
  }

  Widget _buildAuthSection(BuildContext context) {
    return Stack(
      children: [
        _buildAuthPageView(context),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: screenHeight! * 0.25,
            ),
            Container(
              width: 300.0,
              height: 50.0,
              decoration: BoxDecoration(
                color: const Color(0x552B2B2B),
                borderRadius: const BorderRadius.all(Radius.circular(25.0)),
              ),
              child: CustomPaint(
                painter: TabIndicationPainter(pageController: _pageController),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Expanded(
                      child: FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: _onSignInButtonPress,
                        child: Text(
                          CVLocalizations.of(context)!.authBubbleLoginCTA,
                          style: TextStyle(
                            color: left,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                    //Container(height: 33.0, width: 1.0, color: Colors.white),
                    Expanded(
                      child: FlatButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: _onSignUpButtonPress,
                        child: Text(
                          CVLocalizations.of(context)!.authBubbleRegisterCTA,
                          style: TextStyle(
                            color: right,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAuthPageView(BuildContext context) {
    return PageView(
      controller: _pageController,
      onPageChanged: (i) {
        if (i == 0) {
          setState(() {
            right = Colors.white;
            left = Colors.black;
          });
        } else if (i == 1) {
          setState(() {
            right = Colors.black;
            left = Colors.white;
          });
        }
      },
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: screenHeight! * 0.25,
            ),
            Container(
              height: screenHeight! * 0.05,
            ),
            Container(
              height: screenHeight! * 0.70,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[LoginForm()],
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              height: screenHeight! * 0.25,
            ),
            Container(
              height: screenHeight! * 0.05,
            ),
            Container(
              height: screenHeight! * 0.70,
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[RegisterForm()],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _onSignInButtonPress() {
    _pageController!.animateToPage(0,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }

  void _onSignUpButtonPress() {
    _pageController?.animateToPage(1,
        duration: const Duration(milliseconds: 500), curve: Curves.decelerate);
  }
}
