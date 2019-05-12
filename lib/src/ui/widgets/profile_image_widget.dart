import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/initial_circle_avatar_widget.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key key,
    @required this.imageUrl,
  })  : assert(imageUrl != null),
        super(key: key);

  static const RATIO = 1;

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
