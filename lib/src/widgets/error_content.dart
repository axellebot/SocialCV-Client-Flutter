import 'package:cv/src/commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ErrorContent extends StatelessWidget {
  ErrorContent(this.message);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.error,
          color: kCVErrorRed,
        ),
        Text(message),
      ],
    );
  }
}
