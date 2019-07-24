import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class InitialCircleAvatar extends StatefulWidget {
  const InitialCircleAvatar({
    Key key,
    this.text = '',
    this.elevation = 0.0,
    this.backgroundImage,
    this.radius,
    this.minRadius,
    this.maxRadius,
  })  : assert(radius == null || (minRadius == null && maxRadius == null)),
        super(key: key);

  final String text;
  final double elevation;
  final ImageProvider backgroundImage;
  final double radius;
  final double minRadius;
  final double maxRadius;

  @override
  _InitialCircleAvatarState createState() => _InitialCircleAvatarState();
}

class _InitialCircleAvatarState extends State<InitialCircleAvatar> {
  bool _checkLoading = true;

  @override
  void initState() {
    super.initState();
    widget.backgroundImage
        ?.resolve(const ImageConfiguration())
        ?.addListener(ImageStreamListener((_, __) {
      if (mounted) {
        setState(() {
          _checkLoading = false;
        });
      }
    }));
  }

  @override
  Widget build(BuildContext context) {
    return _checkLoading == true
        ? Material(
            shape: CircleBorder(),
            elevation: widget.elevation,
            child: CircleAvatar(
              minRadius: widget.minRadius,
              maxRadius: widget.maxRadius,
              radius: widget.radius,
              child: Text(
                getInitials(widget.text),
                textAlign: TextAlign.center,
              ),
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
