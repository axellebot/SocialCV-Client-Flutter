import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_list_bloc.dart';
import 'package:cv/src/commons/tags.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).searchTitle),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
//        _buildProgressBar(context),
        Column(
          children: <Widget>[
            _buildSearchBox(context),
            _buildList(context),
          ],
        )
      ],
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    return Hero(
      tag: kHeroSearchFAB,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            onSubmitted: null,
            autofocus: true,
            decoration: InputDecoration(
              labelText: Localization.of(context).search,
              prefixIcon: Icon(Icons.search),
              hintText: Localization.of(context).searchSearchBarHint,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildList(BuildContext context) {
    return BlocProvider(
      bloc: ProfileListBloc(),
      child: Container(),
    );
  }
}