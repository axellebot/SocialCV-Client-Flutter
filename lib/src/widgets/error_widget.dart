import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/src/commons/colors.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';

class ErrorContent extends StatelessWidget {
  ErrorContent({
    @required this.message,
  }) : assert(message != null);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.error,
          color: AppColors.kCVErrorRed,
        ),
        Expanded(
          child: Text(message, textAlign: TextAlign.center),
        )
      ],
    );
  }
}

class ErrorCard extends StatelessWidget {
  const ErrorCard({
    Key key,
    @required this.message,
    this.height,
    this.width,
  })  : assert(message != null),
        super(key: key);

  final String message;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(10.0),
        child: ErrorContent(message: message),
      ),
    );
  }
}

class ErrorList extends StatelessWidget {
  ErrorList({
    @required this.error,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(error != null);

  final Object error;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      children: <Widget>[
        ErrorCard(message: translateError(context, error)),
      ],
    );
  }
}
