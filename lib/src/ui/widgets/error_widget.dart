import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_flutter/src/ui/commons/colors.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';

abstract class ErrorWidget extends StatelessWidget {
  final Error error;

  ErrorWidget({Key key, @required this.error})
      : assert(error != null, 'No $Error given'),
        super(key: key);
}

/// [ErrorText] is a [Text] widget to display [Error]
class ErrorText extends ErrorWidget {
  final TextAlign textAlign;

  ErrorText({
    Key key,
    @required Error error,
    this.textAlign = TextAlign.center,
  }) : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return Text(
      translateError(context, error),
      textAlign: textAlign,
    );
  }
}

/// [ErrorRow] is a [Row] widget to display [Error]
class ErrorRow extends ErrorWidget {
  ErrorRow({Key key, @required Error error}) : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.error, color: AppColors.errorColor),
        Expanded(child: ErrorText(error: error))
      ],
    );
  }
}

/// [ErrorTile] is a [ListTile] widget to display [Error]
class ErrorTile extends ErrorWidget {
  ErrorTile({Key key, @required Error error}) : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(MdiIcons.alertCircleOutline),
      title: Text(CVLocalizations.of(context).errorOccurred),
      subtitle: ErrorText(error: error),
    );
  }
}

/// [ErrorCard] is a [Card] widget to display [Error]
class ErrorCard extends ErrorWidget {
  final double height;
  final double width;

  ErrorCard({
    Key key,
    @required Error error,
    this.height,
    this.width,
  }) : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(10.0),
        child: ErrorRow(error: error),
      ),
    );
  }
}

/// [ErrorList] is a [ListView] widget to display [Error]
class ErrorList extends ErrorWidget {
  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  ErrorList({
    Key key,
    @required Error error,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      children: <Widget>[
        ErrorTile(error: error),
      ],
    );
  }
}

/// [ErrorPage] is a [Scaffold] widget to display [Error]
class ErrorPage extends ErrorWidget {
  ErrorPage({Key key, @required Error error}) : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ErrorCard(error: error)),
    );
  }
}

class ErrorApp extends ErrorWidget {
  ErrorApp({Key key, @required Error error}) : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ErrorPage(error: error),
      color: AppColors.primaryColor,
    );
  }
}
