import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage();

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _query = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Container(
            padding: new EdgeInsets.only(right: 12.0),
            child: new TextField(
                onSubmitted: (query) {
                  setState(() {
                    _query = query;
                  });
                },
                autofocus: true,
                decoration: new InputDecoration(
                  hintText: "Search resume...",
                  hintStyle: new TextStyle(
                    color: new Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                style: new TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal)),
          ),
        ),
        body: _query.isEmpty ? new Container() : new Container());
  }
}
