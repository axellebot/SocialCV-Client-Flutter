import 'package:cv/src/utils/utils.dart';
import 'package:flutter/material.dart';

class InitialCircleAvatar extends StatefulWidget {
  InitialCircleAvatar({
    Key key,
    this.text = "",
    this.elevation = 0.0,
    this.backgroundImage,
    this.radius,
  }) : super(key: key);

  final String text;
  final double elevation;
  final ImageProvider backgroundImage;
  final double radius;

  @override
  _InitialCircleAvatarState createState() => new _InitialCircleAvatarState();
}

class _InitialCircleAvatarState extends State<InitialCircleAvatar> {
  bool _checkLoading = true;

  @override
  void initState() {
    super.initState();
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
        ? Material(
            shape: CircleBorder(),
            elevation: widget.elevation,
            child: CircleAvatar(
              radius: this.widget.radius,
              child: Text(getInitials(widget.text)),
            ),
          )
        : Material(
            shape: CircleBorder(),
            elevation: widget.elevation,
            child: CircleAvatar(
              radius: this.widget.radius,
              backgroundImage: widget.backgroundImage,
            ),
          );
  }
}
