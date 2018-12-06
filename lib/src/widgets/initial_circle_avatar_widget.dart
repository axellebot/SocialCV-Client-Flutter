import 'package:cv/src/commons/utils.dart';
import 'package:flutter/material.dart';

class InitialCircleAvatar extends StatefulWidget {
  InitialCircleAvatar(
      {Key key, this.text = "", this.backgroundImage, this.radius})
      : super();

  final String text;
  final ImageProvider backgroundImage;
  final double radius;

  @override
  _InitialCircleAvatarState createState() => new _InitialCircleAvatarState();
}

class _InitialCircleAvatarState extends State<InitialCircleAvatar> {
  bool _checkLoading = true;

  @override
  void initState() {
    widget.backgroundImage
        .resolve(new ImageConfiguration())
        .addListener((_, __) {
      if (mounted) {
        setState(() {
          _checkLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _checkLoading == true
        ? new CircleAvatar(
            radius: this.widget.radius,
            child: new Text(
              getInitials(widget.text),
            ))
        : new CircleAvatar(
            radius: this.widget.radius,
            backgroundImage: widget.backgroundImage,
          );
  }
}
