import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/src/data/repositories/repositories_provider.dart';
import 'package:social_cv_client_flutter/src/ui/commons/tags.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';

/// Add controller for the input
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

          /// TODO: Add search result
//          SliverToBoxAdapter(
//            child: BlocProvider<ElementBloc<ProfileViewModel>>(
//              bloc: ElementBloc<ProfileViewModel>(
//                cvRepository: _repositories.cvRepository,
//              ),
//              child: ProfileListWidget(
//                fromSearch: '',
//                showOptions: true,
//                shrinkWrap: true,
//                physics: ClampingScrollPhysics(),
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}
