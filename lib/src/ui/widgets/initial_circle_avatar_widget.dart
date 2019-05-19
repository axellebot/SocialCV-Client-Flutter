import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';

class InitialCircleAvatar extends StatefulWidget {
  final String text;
  final double elevation;
  final ImageProvider backgroundImage;
  final double radius;
  final double minRadius;
  final double maxRadius;

  InitialCircleAvatar({
    Key key,
    this.text = '',
    this.elevation = 0.0,
    this.backgroundImage,
    this.radius,
    this.minRadius,
    this.maxRadius,
  })  : assert(radius == null || (minRadius == null && maxRadius == null)),
        super(key: key);

  @override
  _InitialCircleAvatarState createState() => new _InitialCircleAvatarState();
}

class _InitialCircleAvatarState extends State<InitialCircleAvatar> {
  final String _tag = '$_InitialCircleAvatarState';

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
    Logger.log('$_tag:$build');

    return _checkLoading == true
        ? Material(
            shape: CircleBorder(),
            elevation: widget.elevation,
            child: CircleAvatar(
              minRadius: widget.minRadius,
              maxRadius: widget.maxRadius,
              radius: widget.radius,
              child: Text(getInitials(widget.text)),
            ),
          )
        : Material(
            shape: CircleBorder(),
            elevation: widget.elevation,
            child: CircleAvatar(
              minRadius: widget.minRadius,
              maxRadius: widget.maxRadius,
              radius: widget.radius,
              backgroundImage: widget.backgroundImage,
            ),
          );
  }
}
