import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// [CustomErrorWidget] is a based widget for error
///
/// Must be initialized with an [error]
abstract class CustomErrorWidget extends StatelessWidget {
  final Object error;

  const CustomErrorWidget({Key? key, required this.error}) : super(key: key);
}

/// [ErrorIcon] is a [Icon] like widget to display error
///
/// See [Icon] widget for more documentation
class ErrorIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color color;
  final String? semanticLabel;
  final TextDirection? textDirection;

  const ErrorIcon({
    Key? key,
    this.icon = MdiIcons.alertCircleOutline,
    this.size,
    this.color = AppStyles.errorColor,
    this.semanticLabel,
    this.textDirection,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
      semanticLabel: semanticLabel,
      textDirection: textDirection,
    );
  }
}

/// [ErrorText] is a [Text] like widget like to display error
///
/// See [Text] widget for more documentation
class ErrorText extends CustomErrorWidget {
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final TextAlign textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final double? textScaleFactor;
  final int? maxLines;
  final String? semanticsLabel;

  const ErrorText({
    Key? key,
    required Object error,
    this.style,
    this.strutStyle,
    this.textAlign = TextAlign.center,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.textScaleFactor,
    this.maxLines,
    this.semanticsLabel,
  }) : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return Text(
      translateError(context, error),
      style: style,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      locale: locale,
      softWrap: softWrap,
      overflow: overflow,
      textScaleFactor: textScaleFactor,
      maxLines: maxLines,
      semanticsLabel: semanticsLabel,
    );
  }
}

/// [ErrorRow] is a [Row] like widget to display [Error]
///
/// See [Row] widget for more documentation
class ErrorRow extends CustomErrorWidget {
  const ErrorRow({Key? key, required Object error})
      : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        const ErrorIcon(),
        Expanded(child: ErrorText(error: error)),
      ],
    );
  }
}

/// [ErrorTile] is a [ListTile] like widget to display error
///
/// See [ListTile] widget for more documentation
class ErrorTile extends CustomErrorWidget {
  const ErrorTile({Key? key, required Object error})
      : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const ErrorIcon(),
      title: Text(CVLocalizations.of(context)!.errorOccurred),
      subtitle: ErrorText(
        error: error,
        textAlign: TextAlign.left,
      ),
    );
  }
}

/// [ErrorCard] is a [Card] like widget to display error
///
/// See [Card] widget for more documentation
class ErrorCard extends CustomErrorWidget {
  final double? height;
  final double? width;

  const ErrorCard({
    Key? key,
    required Object error,
    this.height,
    this.width,
  }) : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppStyles.cardDefaultElevation,
      child: Container(
        height: height,
        width: width,
        padding: AppStyles.cardDefaultPadding,
        child: ErrorRow(error: error),
      ),
    );
  }
}

/// [ErrorList] is a [ListView] like widget to display error
///
/// See [ListView] widget for more documentation
class ErrorList extends CustomErrorWidget {
  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const ErrorList({
    Key? key,
    required Object error,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: <Widget>[
        ErrorTile(error: error),
      ],
    );
  }
}

/// [ErrorPage] is a [Scaffold] like widget to display error
///
/// See [Scaffold] widget for more documentation
class ErrorPage extends CustomErrorWidget {
  const ErrorPage({Key? key, required Object error})
      : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: ErrorCard(error: error)),
    );
  }
}

/// [ErrorApp] is a [MaterialApp] like widget to display error
///
/// See [MaterialApp] widget for more documentation
class ErrorApp extends CustomErrorWidget {
  const ErrorApp({Key? key, required Object error})
      : super(key: key, error: error);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ErrorPage(error: error),
      color: AppStyles.primaryColor,
    );
  }
}
