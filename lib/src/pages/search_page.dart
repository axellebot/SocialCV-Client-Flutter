import 'package:cv/src/commons/colors.dart';
import 'package:cv/src/commons/tags.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage();

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: kHeroSearchFAB,
      child: Scaffold(
        backgroundColor: kCVAccentColor,
        appBar: AppBar(
          title: TextField(
            onSubmitted: (query) {
              print(query);
            },
            autofocus: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              prefixIcon: Icon(Icons.search),
              hintText: "Search resume...",
            ),
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        body: Container(),
      ),
    );
  }
}
