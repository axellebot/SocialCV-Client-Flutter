import 'package:cv/src/commons/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardError extends StatelessWidget {
  CardError(this.message);
  final String message;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.error,
              color: kCVErrorRed,
            ),
            Text(message),
          ],
        ),
      ),
    );
  }
}
