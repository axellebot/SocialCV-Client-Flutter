import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/initial_circle_avatar_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logging_service.dart';

class ProfileImage extends StatelessWidget {
  final String _tag = '$ProfileImage';

  ProfileImage({Key key, @required this.imageUrl})
      : assert(imageUrl != null),
        super(key: key);

  static const RATIO = 1;

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:$build');

    return Material(
      borderRadius: new BorderRadius.circular(75.0),
      elevation: 2.0,
      child: InitialCircleAvatar(),
    );
  }
}
