import 'package:cv/src/widgets/initial_circle_avatar_widget.dart';
import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  static const RATIO = 1;

  ProfileImage(this.imageUrl);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return new Material(
      borderRadius: new BorderRadius.circular(75.0),
      elevation: 2.0,
      child: InitialCircleAvatar(),
    );
  }
}
