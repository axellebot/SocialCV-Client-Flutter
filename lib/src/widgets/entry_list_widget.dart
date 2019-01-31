import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';
import 'package:social_cv_client_flutter/src/widgets/entry_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/sort_box_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/sort_dialog_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/sort_list_tile_widget.dart';

class EntryListWidget extends StatelessWidget {
  const EntryListWidget({
    Key key,
    this.fromGroupModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(fromGroupModel != null || fromSearch != null),
        super(key: key);

  final GroupModel fromGroupModel;
  final Object fromSearch;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (fromGroupModel != null) {
      return _EntryListFromGroup(
        groupModel: fromGroupModel,
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
    @required this.groupModel,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(groupModel != null);

  final GroupModel groupModel;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    EntryListBloc entryListBloc = BlocProvider.of<EntryListBloc>(context);
    entryListBloc.fetchGroupEntries(groupModel.id);

    return StreamBuilder<List<EntryModel>>(
      stream: entryListBloc.entriesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<EntryModel>> snapshot) {
        if (snapshot.hasError) {
          return ErrorList(
            error: snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _EntryList(
            entryModels: snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else {
          return LoadingList(
            count: groupModel.entryIds.length,
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
    @required this.entryModels,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(entryModels != null);

  final List<EntryModel> entryModels;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    EntryListBloc _entryListBloc = BlocProvider.of<EntryListBloc>(context);

    final List<SortListItem> sortItems = <SortListItem>[
      SortListItem(field: "name", title: "Name", value: SortState.NoSort)
    ];

    return ListView.builder(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      itemCount: showOptions ? entryModels.length + 2 : entryModels.length,
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
          if (i == entryModels.length) {
            return Center(
              child: FlatButton(
                onPressed: null,
                child: Text(CVLocalizations.of(context).entryListLoadMore),
              ),
            );
          }
        }
        return EntryWidget(entryModel: entryModels[i]);
      },
    );
  }
}
