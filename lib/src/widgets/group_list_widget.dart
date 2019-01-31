import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/blocs/bloc_provider.dart';
import 'package:social_cv_client_flutter/src/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';
import 'package:social_cv_client_flutter/src/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/group_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/sort_box_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/sort_dialog_widget.dart';
import 'package:social_cv_client_flutter/src/widgets/sort_list_tile_widget.dart';

/// A widget to list all [GroupModel] from [PartModel] or from a search
class GroupListWidget extends StatelessWidget {
  GroupListWidget({
    Key key,
    this.fromPartModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(fromPartModel != null || fromSearch != null),
        super(key: key);

  final PartModel fromPartModel;
  final Object fromSearch;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (fromPartModel != null) {
      return _GroupListFromPartModel(
        partModel: fromPartModel,
        showOptions: showOptions,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    } else if (fromSearch != null) {
      return _GroupListFromSearch(
        search: fromSearch,
        showOptions: showOptions,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    } else {
      return ErrorList(
        error: CVLocalizations.of(context).notYetImplemented,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    }
  }
}

/// A widget to list all [GroupModel] from [PartModel]
class _GroupListFromPartModel extends StatelessWidget {
  _GroupListFromPartModel({
    @required this.partModel,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(partModel != null);

  final PartModel partModel;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    GroupListBloc _groupListBloc = BlocProvider.of<GroupListBloc>(context);
    _groupListBloc.fetchPartGroups(partModel.id);

    return StreamBuilder<List<GroupModel>>(
      stream: _groupListBloc.groupsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<GroupModel>> snapshot) {
        if (snapshot.hasError) {
          return ErrorList(
            error: snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _GroupList(
            groupModels: snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        }
        return LoadingList(
          count: partModel.groupIds.length,
          scrollDirection: this.scrollDirection,
          shrinkWrap: this.shrinkWrap,
          physics: this.physics,
        );
      },
    );
  }
}

/// A widget to list all groups from search
class _GroupListFromSearch extends StatelessWidget {
  _GroupListFromSearch({
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

/// A widget to list all [GroupModel]
class _GroupList extends StatelessWidget {
  _GroupList({
    @required this.groupModels,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(groupModels != null);

  final List<GroupModel> groupModels;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    GroupListBloc _groupListBloc = BlocProvider.of<GroupListBloc>(context);

    final List<SortListItem> sortItems = <SortListItem>[
      SortListItem(field: "title", title: "Title", value: SortState.NoSort)
    ];

    return ListView.builder(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      itemCount: showOptions ? groupModels.length + 2 : groupModels.length,
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
                          title:
                              Text(CVLocalizations.of(context).partListSorting),
                          sortItems: sortItems,
                        );
                      },
                    );
                  },
                ),
                StreamBuilder<String>(
                  stream: _groupListBloc.groupPerPage,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return DropdownButton(
                      value: snapshot.data,
                      hint:
                          Text(CVLocalizations.of(context).partListItemPerPage),
                      items: getDropDownMenuElementPerPage(),
                      onChanged: (value) {
                        _groupListBloc.setItemsPerPage(value);
                      },
                    );
                  },
                ),
              ],
            );
          }
          i--;
          if (i == groupModels.length) {
            return Center(
              child: FlatButton(
                onPressed: null,
                child: Text(CVLocalizations.of(context).groupListLoadMore),
              ),
            );
          }
        }
        return GroupWidget(groupModel: groupModels[i]);
      },
    );
  }
}
