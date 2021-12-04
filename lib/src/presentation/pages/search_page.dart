import 'package:flutter/material.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// Add controller for the input
class SearchPage extends StatelessWidget {
  final String _tag = '$SearchPage';

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: Text(CVLocalizations.of(context)!.searchTitle),
          ),
          SliverToBoxAdapter(
            child: Hero(
              tag: AppHeroes.searchFab,
              child: Card(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: TextField(
                    onSubmitted: null,
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: CVLocalizations.of(context)!.search,
                      prefixIcon: Icon(Icons.search),
                      hintText:
                          CVLocalizations.of(context)!.searchSearchBarHint,
                    ),
                  ),
                ),
              ),
            ),
          ),

          /// TODO: Add search result
//          SliverToBoxAdapter(
//            child: BlocProvider<ElementBloc<ProfileEntity>>(
//              bloc: ElementBloc<ProfileEntity>(
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
