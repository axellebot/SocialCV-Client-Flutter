import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class ArcBannerImage extends StatelessWidget {
  final String _tag = '$ArcBannerImage';

  final ImageProvider imageProvider;

  ArcBannerImage({Key? key, required this.imageProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');

    final screenWidth = MediaQuery.of(context).size.width;

    return ClipPath(
      clipper: ArcClipper(),
      child: Image(
        image: imageProvider,
        width: screenWidth,
        height: 230.0,
        fit: BoxFit.cover,
      ),
    );
  }
}

class ArcClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height - 30);

    final firstControlPoint = Offset(size.width / 4, size.height);
    final firstPoint = Offset(size.width / 2, size.height);
    path.quadraticBezierTo(firstControlPoint.dx, firstControlPoint.dy,
        firstPoint.dx, firstPoint.dy);

    final secondControlPoint =
        Offset(size.width - (size.width / 4), size.height);
    final secondPoint = Offset(size.width, size.height - 30);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondPoint.dx, secondPoint.dy);

    path.lineTo(size.width, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
