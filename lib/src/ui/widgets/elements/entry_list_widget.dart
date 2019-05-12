import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/entry_profile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_box_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_dialog_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_list_tile_widget.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';

class EntryListWidget extends StatelessWidget {
  const EntryListWidget({
    Key key,
    this.fromGroupViewModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(fromGroupViewModel != null || fromSearch != null),
        super(key: key);

  final GroupViewModel fromGroupViewModel;
  final Object fromSearch;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (fromGroupViewModel != null) {
      return _EntryListFromGroup(
        groupViewModel: fromGroupViewModel,
        showOptions: showOptions,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    } else if (fromSearch != null) {
      return _EntryListFromSearch(
        search: fromSearch,
        showOptions: showOptions,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    }
    return ErrorList(
      error: CVLocalizations.of(context).notSupported,
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
    );
  }
}

class _EntryListFromGroup extends StatelessWidget {
  _EntryListFromGroup({
    @required this.groupViewModel,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(groupViewModel != null);

  final GroupViewModel groupViewModel;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    EntryListBloc entryListBloc = BlocProvider.of<EntryListBloc>(context);
    entryListBloc.fetchGroupEntries(groupViewModel.id);

    return StreamBuilder<List<EntryViewModel>>(
      stream: entryListBloc.entriesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<EntryViewModel>> snapshot) {
        if (snapshot.hasError) {
          return ErrorList(
            error: snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _EntryList(
            EntryViewModels: snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else {
          return LoadingList(
            count: groupViewModel.entryIds.length,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        }
      },
    );
  }
}

class _EntryListFromSearch extends StatelessWidget {
  _EntryListFromSearch({
    @required this.search,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(search != null);

  final Object search;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ErrorList(
      error: CVLocalizations.of(context).notYetImplemented,
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
    );
  }
}

class _EntryList extends StatelessWidget {
  _EntryList({
    @required this.EntryViewModels,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(EntryViewModels != null);

  final List<EntryViewModel> EntryViewModels;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    ElementListBloc<EntryViewModel> _entryListBloc =
        BlocProvider.of<ElementListBloc<EntryViewModel>>(context);

    final List<SortListItem> sortItems = <SortListItem>[
      SortListItem(field: 'name', title: 'Name', value: SortState.NoSort)
    ];

    return ListView.builder(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      itemCount:
          showOptions ? EntryViewModels.length + 2 : EntryViewModels.length,
      itemBuilder: (BuildContext context, int i) {
        if (showOptions) {
          if (i == 0) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  icon: Icon(Icons.sort_by_alpha),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SortDialog(
                          title: Text(
                              CVLocalizations.of(context).entryListSorting),
                          sortItems: sortItems,
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<String>(
                  stream: _entryListBloc.entryPerPage,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return DropdownButton(
                      value: snapshot.data,
                      hint:
                          Text(CVLocalizations.of(context).partListItemPerPage),
                      items: getDropDownMenuElementPerPage(),
                      onChanged: (value) {
                        _entryListBloc.setItemsPerPage(value);
                      },
                    );
                  },
                ),
              ],
            );
          }
          i--;
          if (i == EntryViewModels.length) {
            return Center(
              child: FlatButton(
                onPressed: null,
                child: Text(CVLocalizations.of(context).entryListLoadMore),
              ),
            );
          }
        }
        return EntryProfileWidget(entry: EntryViewModels[i]);
      },
    );
  }
}
