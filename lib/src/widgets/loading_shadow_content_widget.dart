import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// LoadingCard displays lines with opacity moving up and down
/// Specify the number of loading lines to display

class LoadingShadowContent extends StatefulWidget {
  LoadingShadowContent({
    this.numberOfTitleLines = 1,
    this.numberOfContentLines = 3,
    this.padding = const EdgeInsets.all(0.0),
  });

  final int numberOfTitleLines;
  final int numberOfContentLines;
  final EdgeInsetsGeometry padding;

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
    _loadingOpacity.dispose();
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
              // constraints: BoxConstraints.expand(),
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
