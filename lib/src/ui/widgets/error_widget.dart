import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_flutter/src/ui/commons/colors.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';

class ErrorContent extends StatelessWidget {
  ErrorContent({
    @required this.message,
  }) : assert(message != null);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          Icons.error,
          color: AppColors.errorColor,
        ),
        Expanded(
          child: Text(message, textAlign: TextAlign.center),
        )
      ],
    );
  }
}

class ErrorTile extends StatelessWidget {
  final String message;

  const ErrorTile({
    Key key,
    @required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(MdiIcons.alertCircleOutline),
      title: Text(CVLocalizations.of(context).errorOccurred),
      subtitle: Text(message),
    );
  }
}

class ErrorCard extends StatelessWidget {
  final String message;
  final double height;
  final double width;

  const ErrorCard({
    Key key,
    @required this.message,
    this.height,
    this.width,
  })  : assert(message != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(10.0),
        child: ErrorContent(message: message),
      ),
    );
  }
}

class ErrorList extends StatelessWidget {
  ErrorList({
    @required this.error,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(error != null);

  final Object error;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      children: <Widget>[
        ErrorCard(message: translateError(context, error)),
      ],
    );
  }
}
