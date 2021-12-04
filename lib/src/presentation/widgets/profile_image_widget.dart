import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class ProfileImage extends StatelessWidget {
  final String _tag = '$ProfileImage';

  ProfileImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  static const RATIO = 1;

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');

    return Material(
      borderRadius: BorderRadius.circular(75.0),
      elevation: 2.0,
      child: const InitialCircleAvatar(),
    );
  }
}
