import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CardError extends StatelessWidget {
  const CardError({
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
