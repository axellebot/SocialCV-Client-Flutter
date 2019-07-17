import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/ui/commons/assets.dart';
import 'package:social_cv_client_flutter/src/ui/commons/colors.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/login_form_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/register_form_widget.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final String _tag = '$_AuthPageState';

  // Variable
  double screenWidth;
  double screenHeight;

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  PageController _pageController;

  // Business
  @override
  void initState() {
    print('$_tag:$initState()');
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    print('$_tag:$dispose()');
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('$_tag:$build');
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    screenHeight = (screenHeight > AppDimensions.authPageMinHeight)
        ? screenHeight
        : AppDimensions.authPageMinHeight;

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocListenerTree(
        blocListeners: <BlocListener>[
          BlocListener<AuthenticationEvent, AuthenticationState>(
            bloc: BlocProvider.of<AuthenticationBloc>(context),
            listener: (BuildContext context, AuthenticationState state) {
              if (state is AuthenticationAuthenticated) {
                Scaffold.of(context).showSnackBar(SnackBar(
                  backgroundColor: AppColors.successColor,
                  content: Text(CVLocalizations.of(context).authSignInSucceed),
                ));
                Future.delayed(Duration(seconds: 1))
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
      height: screenHeight * 0.25,
      width: screenWidth,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Image.asset(
            AppAssets.loginLogoImage,
            fit: BoxFit.scaleDown,
          ),
          Text(
            CVLocalizations.of(context).authTitle,
            style: Theme.of(context)
                .textTheme
                .title
                .copyWith(color: AppColors.white),
          ),
        ],
      ),
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
              height: screenHeight * 0.25,
            ),
            Container(
              height: screenHeight * 0.05,
              color: Colors.transparent,
              child: DotsIndicator(
                color: AppColors.white,
                controller: _pageController,
                itemCount: 2,
                onPageSelected: (int page) {
                  _pageController.animateToPage(
                    page,
                    duration: _kDuration,
                    curve: _kCurve,
                  );
                },
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
      children: <Widget>[
        Column(
          children: <Widget>[
            Container(
              height: screenHeight * 0.25,
            ),
            Container(
              height: screenHeight * 0.05,
            ),
            Container(
              height: screenHeight * 0.70,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LoginForm(),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: <Widget>[
            Container(
              height: screenHeight * 0.25,
            ),
            Container(
              height: screenHeight * 0.05,
            ),
            Container(
              height: screenHeight * 0.70,
              padding: EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RegisterForm(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// An indicator showing the currently selected page of a PageController
class DotsIndicator extends AnimatedWidget {
  DotsIndicator({
    this.controller,
    this.itemCount,
    this.onPageSelected,
    this.color: Colors.white,
  }) : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 8.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;
    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          elevation: AppDimensions.defaultCardElevation,
          color: color,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize * zoom,
            height: _kDotSize * zoom,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
