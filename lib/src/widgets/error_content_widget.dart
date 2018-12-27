import 'package:cv/src/commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
          color: kCVErrorRed,
        ),
        Expanded(
          child: Text(message, textAlign: TextAlign.center),
        )
      ],
    );
  }
}
