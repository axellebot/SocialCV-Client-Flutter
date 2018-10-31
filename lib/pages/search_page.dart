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
    return Scaffold(
        appBar: AppBar(
          title: Container(
            padding: EdgeInsets.only(right: 12.0),
            child: TextField(
                onSubmitted: (query) {
                  setState(() {
                    _query = query;
                  });
                },
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Search resume...",
                  hintStyle: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.0,
                    fontWeight: FontWeight.normal)),
          ),
        ),
        body: _query.isEmpty ? Container() : Container());
  }
}
