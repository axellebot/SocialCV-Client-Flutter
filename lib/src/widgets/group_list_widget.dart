import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/group_list_bloc.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:cv/src/widgets/group_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:cv/src/widgets/sliver_delagate.dart';
import 'package:cv/src/widgets/sort_box_widget.dart';
import 'package:cv/src/widgets/sort_dialog_widget.dart';
import 'package:cv/src/widgets/sort_list_tile_widget.dart';
import 'package:flutter/material.dart';

class GroupListWidget extends StatelessWidget {
  GroupListWidget({
    this.fromPartModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(fromPartModel != null || fromSearch != null);

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
    }
    return ErrorContent(message: "Not supported");
  }
}

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
          return _GroupListError(
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
        return _GroupListLoading(
          count: partModel.groupIds.length,
          scrollDirection: this.scrollDirection,
          shrinkWrap: this.shrinkWrap,
          physics: this.physics,
        );
      },
    );
  }
}

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
    return ErrorContent(message: "Not Implemented Yet");
  }
}

class _GroupListError extends ListView {
  _GroupListError({
    @required this.error,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(error != null);

  final Object error;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ListView(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: <Widget>[
        CardError(message: translateError(context, error)),
      ],
    );
  }
}

class _GroupListLoading extends StatelessWidget {
  _GroupListLoading({
    @required this.count,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(count != null && count != 0);

  final int count;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: count,
      itemBuilder: (BuildContext context, int i) {
        return LoadingShadowContent(
          numberOfTitleLines: 1,
          numberOfContentLines: 3,
        );
      },
    );
  }
}

class _GroupList extends StatelessWidget {
  _GroupList(
      {@required this.groupModels,
      this.showOptions = false,
      this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics})
      : assert(groupModels != null);

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

    List<Widget> slivers = [];

    if (showOptions) {
      slivers.add(
        SliverPersistentHeader(
          pinned: false,
          delegate: SliverHeaderDelegate(
              maxHeight: 40,
              minHeight: 40,
              child: Row(
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
                                Text(Localization.of(context).partListSorting),
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
                            Text(Localization.of(context).partListItemPerPage),
                        items: getDropDownMenuElementPerPage(),
                        onChanged: (value) {
                          _groupListBloc.setItemsPerPage(value);
                        },
                      );
                    },
                  ),
                ],
              )),
        ),
      );
    }

    slivers.add(
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int i) {
            return GroupWidget(groupModel: groupModels[i]);
          },
          childCount: groupModels.length,
        ),
      ),
    );

    if (showOptions) {
      slivers.add(SliverList(
        delegate: SliverChildListDelegate(
          [
            Center(
              child: FlatButton(
                onPressed: null,
                child: Text(Localization.of(context).groupListLoadMore),
              ),
            ),
          ],
        ),
      ));
    }
    return CustomScrollView(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      slivers: slivers,
    );
  }
}
