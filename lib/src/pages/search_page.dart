import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_list_bloc.dart';
import 'package:cv/src/commons/tags.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/widgets/profile_list_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).searchTitle),
      ),
      body: Column(
        children: <Widget>[
          Hero(
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
          ),
          Expanded(
            child: BlocProvider(
              bloc: ProfileListBloc(),
              child: ProfileListWidget(fromSearch: ""),
            ),
          )
        ],
      ),
    );
  }
}
