import 'package:cv/src/blocs/search_bloc.dart';
import 'package:cv/src/commons/tags.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/widgets/card_error.dart';
import 'package:cv/src/widgets/profile_tile_widget.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  SearchPage();

  @override
  State<StatefulWidget> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchBloc searchBloc;

  _SearchPageState() {
    searchBloc = SearchBloc();
  }

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
        _buildProgressBar(context),
        Column(
          children: <Widget>[
            _buildSearchBox(context),
            _buildList(context),
          ],
        )
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    return StreamBuilder<bool>(
      stream: searchBloc.isFetchingStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return LinearProgressIndicator();
        }
        return Container();
      },
    );
  }

  Widget _buildSearchBox(BuildContext context) {
    return Hero(
      tag: kHeroSearchFAB,
      child: Card(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            onSubmitted: searchBloc.fetchProfiles,
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
    return StreamBuilder<List<ProfileModel>>(
      stream: searchBloc.profilesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProfileModel>> snapshot) {
        if (snapshot.hasError) {
          return CardError(translateError(context, snapshot.error));
        } else if (snapshot.hasData) {
          List<ProfileModel> profileModels = snapshot.data;
          return Expanded(
            child: ListView.builder(
              itemCount: profileModels.length,
              itemBuilder: (BuildContext context, int i) {
                return ProfileTile(profileModels[i]);
              },
            ),
          );
        }
        return Card(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[Text("Search profile")],
            ),
          ),
        );
      },
    );
  }
}
