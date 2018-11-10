import 'package:cv/src/commons/utils.dart';
import 'package:flutter/material.dart';

class InitialCircleAvatar extends StatefulWidget {
  final String text;
  final ImageProvider backgroundImage;

  InitialCircleAvatar({Key key, this.text, this.backgroundImage});

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
            child: new Text(
            getInitials(widget.text),
          ))
        : new CircleAvatar(
            backgroundImage: widget.backgroundImage,
          );
  }
}
