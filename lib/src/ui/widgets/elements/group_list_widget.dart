import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/group_profile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_box_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_dialog_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_list_tile_widget.dart';

/// A widget to list all [GroupViewModel] from [PartViewModel] or from a search
class GroupListWidget extends StatelessWidget {
  GroupListWidget({
    Key key,
    this.fromPartViewModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })
      : assert(fromPartViewModel != null || fromSearch != null),
        super(key: key);

  final PartViewModel fromPartViewModel;
  final Object fromSearch;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (fromPartViewModel != null) {
      return _GroupListFromPartViewModel(
        partViewModel: fromPartViewModel,
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
        error: CVLocalizations
            .of(context)
            .notYetImplemented,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    }
  }
}

/// A widget to list all [GroupViewModel] from [PartViewModel]
class _GroupListFromPartViewModel extends StatelessWidget {
  _GroupListFromPartViewModel({
    @required this.partViewModel,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(partViewModel != null);

  final PartViewModel partViewModel;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    ElementListBloc<GroupViewModel> _groupListBloc =
    BlocProvider.of<ElementListBloc<GroupViewModel>>(context);
    _groupListBloc.dispatch(
      ElementListFetchFromParent(parentId: partViewModel.id);

      return StreamBuilder<List<GroupViewModel>>(
      stream: _groupListBloc.groupsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<GroupViewModel>> snapshot) {
        if (snapshot.hasError) {
          return ErrorList(
            error: snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _GroupList(
            groupViewModels: snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        }
        return LoadingList(
          count: partViewModel.groupIds.length,
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
      error: CVLocalizations
          .of(context)
          .notYetImplemented,
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
    );
  }
}

/// A widget to list all [GroupViewModel]
class _GroupList extends StatelessWidget {
  _GroupList({
    @required this.groupViewModels,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(groupViewModels != null);

  final List<GroupViewModel> groupViewModels;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    ElementListBloc<GroupViewModel> _groupListBloc = BlocProvider.of<
        ElementListBloc<GroupViewModel>>(context);

    final List<SortListItem> sortItems = <SortListItem>[
      SortListItem(field: 'title', title: 'Title', value: SortState.NoSort)
    ];

    return ListView.builder(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      itemCount:
      showOptions ? groupViewModels.length + 2 : groupViewModels.length,
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
                          Text(CVLocalizations
                              .of(context)
                              .partListSorting),
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
                      Text(CVLocalizations
                          .of(context)
                          .partListItemPerPage),
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
          if (i == groupViewModels.length) {
            return Center(
              child: FlatButton(
                onPressed: null,
                child: Text(CVLocalizations
                    .of(context)
                    .groupListLoadMore),
              ),
            );
          }
        }
        return GroupProfileWidget(group: groupViewModels[i]);
      },
    );
  }
}
