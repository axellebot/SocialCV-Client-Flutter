import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:social_cv_client_flutter/src/ui/commons/colors.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';

/// LoadingCard displays lines with opacity moving up and down
/// Specify the number of loading lines to display

class LoadingShadowContent extends StatefulWidget {
  final int numberOfTitleLines;
  final int numberOfContentLines;
  final EdgeInsetsGeometry padding;

  const LoadingShadowContent({
    Key key,
    this.numberOfTitleLines = 0,
    this.numberOfContentLines = 0,
    this.padding = const EdgeInsets.all(0.0),
  })  : assert(numberOfTitleLines != null),
        assert(numberOfContentLines != null),
        assert(padding != null),
        super(key: key);

  _LoadingShadowContentState createState() => _LoadingShadowContentState();
}

class _LoadingShadowContentState extends State<LoadingShadowContent>
    with SingleTickerProviderStateMixin {
  AnimationController _loadingOpacity;
  Animation _opacity;
  Random _rand;
  double _divideFactor;

  _LoadingShadowContentState();

  @override
  void initState() {
    _rand = Random();
    _divideFactor = (_rand.nextInt(5) + 1.4);
    _loadingOpacity = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _opacity = Tween(begin: 0.4, end: 1.0).animate(_loadingOpacity)
      ..addListener(() {
        setState(() {});
      });
    _animateForward();
    super.initState();
  }

  @override
  void dispose() {
    _loadingOpacity?.dispose();
    super.dispose();
  }

  void _animateForward() async {
    await _loadingOpacity.forward().then((_) {
      _animateReverse();
    });
  }

  void _animateReverse() async {
    await _loadingOpacity.reverse().then((_) {
      _animateForward();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgets = [];
    for (int i = 0; i < widget.numberOfTitleLines; i++) {
      _widgets.add(
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6.0),
            child: Container(
              height: 13.0,
              width: MediaQuery.of(context).size.width / _divideFactor,

              //constraints: BoxConstraints.expand(),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(_opacity.value),
                  borderRadius: BorderRadius.circular(6.5)),
            ),
          ),
        ),
      );
    }

    for (int i = 0; i < widget.numberOfContentLines; i++) {
      _widgets.add(
        Container(
          padding: const EdgeInsets.only(top: 4.0),
          child: Container(
            height: 13.0,
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(_opacity.value),
                borderRadius: BorderRadius.circular(6.5)),
          ),
        ),
      );
    }
    return Container(
      padding: widget.padding,
      child: Column(
        children: _widgets,
      ),
    );
  }
}

class LoadingCard extends StatelessWidget {
  const LoadingCard({
    Key key,
    this.height,
    this.width,
    this.numberOfTitleLines = 1,
    this.numberOfContentLines = 3,
  }) : super(key: key);

  final double height;
  final double width;
  final int numberOfTitleLines;
  final int numberOfContentLines;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: height,
        width: width,
        padding: EdgeInsets.all(AppDimensions.cardDefaultPadding),
        child: LoadingShadowContent(
          numberOfTitleLines: numberOfTitleLines,
          numberOfContentLines: numberOfContentLines,
        ),
      ),
    );
  }
}

/// A widget to list loading entries
class LoadingList extends StatelessWidget {
  LoadingList({
    @required this.count,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(count != null);

  final int count;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: LoadingShadowContent(
            numberOfTitleLines: 1,
            numberOfContentLines: 2,
          ),
        );
      },
    );
  }
}

class LoadingPage extends StatelessWidget {
  LoadingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class LoadingApp extends StatelessWidget {
  LoadingApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoadingPage(),
      color: AppColors.primaryColor,
    );
  }
}
