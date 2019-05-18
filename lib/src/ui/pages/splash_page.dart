import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/src/ui/commons/colors.dart';

class SplashPage extends StatelessWidget {
  final String _tag = 'SplashPage';

  @override
  Widget build(BuildContext context) {
    print('$_tag:$build');

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Social CV"),
          ],
        ),
      ),
    );
  }
}
