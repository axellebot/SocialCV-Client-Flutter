import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/commons/tags.dart';
import 'package:social_cv_client_flutter/src/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/repositories/repositories_provider.dart';
import 'package:social_cv_client_flutter/src/widgets/profile_list_widget.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RepositoriesProvider _repositories = RepositoriesProvider.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(CVLocalizations.of(context).searchTitle),
          ),
          SliverToBoxAdapter(
            child: Hero(
              tag: kHeroSearchFAB,
              child: Card(
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    onSubmitted: null,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: CVLocalizations.of(context).search,
                      prefixIcon: Icon(Icons.search),
                      hintText: CVLocalizations.of(context).searchSearchBarHint,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: BlocProvider(
              bloc: ProfileListBloc(
                cvRepository: _repositories.cvRepository,
                preferencesRepository: _repositories.preferencesRepository,
              ),
              child: ProfileListWidget(
                fromSearch: '',
                showOptions: true,
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
