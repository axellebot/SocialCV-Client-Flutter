import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/part_list_bloc.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:cv/src/widgets/part_widget.dart';
import 'package:cv/src/widgets/sliver_delagate.dart';
import 'package:cv/src/widgets/sort_box_widget.dart';
import 'package:cv/src/widgets/sort_dialog_widget.dart';
import 'package:cv/src/widgets/sort_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PartListWidget extends StatelessWidget {
  PartListWidget({
    Key key,
    this.fromProfileModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key);

  final ProfileModel fromProfileModel;
  final Object fromSearch;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (fromProfileModel != null) {
      return _PartListFromProfile(
        fromProfileModel,
        showOptions: showOptions,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    } else if (fromSearch != null) {
      return _PartListFromSearch(
        fromSearch,
        showOptions: showOptions,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    }
    return ErrorContent(message: "Not supported");
  }
}

class _PartListFromProfile extends StatelessWidget {
  _PartListFromProfile(this.profileModel,
      {this.showOptions = false,
      this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final ProfileModel profileModel;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    PartListBloc _partListBloc = BlocProvider.of<PartListBloc>(context);
    _partListBloc.fetchProfileParts(profileModel.id);

    return StreamBuilder<List<PartModel>>(
      stream: _partListBloc.partsStream,
      builder: (BuildContext context, AsyncSnapshot<List<PartModel>> snapshot) {
        if (snapshot.hasError) {
          return _PartListError(
            snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _PartList(
            snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        }
        return _PartListLoading(
          profileModel.partIds.length,
          scrollDirection: this.scrollDirection,
          shrinkWrap: this.shrinkWrap,
          physics: this.physics,
        );
      },
    );
  }
}

class _PartListFromSearch extends StatelessWidget {
  _PartListFromSearch(this.search,
      {this.showOptions = false,
      this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

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

class _PartListError extends StatelessWidget {
  _PartListError(this.error,
      {this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

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

class _PartListLoading extends StatelessWidget {
  const _PartListLoading(this.count,
      {this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

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
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          numberOfTitleLines: 0,
          numberOfContentLines: 4,
        );
      },
    );
  }
}

class _PartList extends StatelessWidget {
  _PartList(this.parts,
      {this.showOptions = false,
      this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final List<PartModel> parts;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    PartListBloc _partListBloc = BlocProvider.of<PartListBloc>(context);

    final List<SortListItem> sortItems = <SortListItem>[
      SortListItem(field: "order", title: "Order", value: SortState.NoSort),
      SortListItem(field: "name", title: "Name", value: SortState.NoSort)
    ];

    List<Widget> slivers = [];

    if (showOptions) {
      slivers.add(
        SliverPersistentHeader(
          pinned: true,
          delegate: SliverHeaderDelegate(
              maxHeight: kCVListHeaderDefaultHeightMax,
              minHeight: kCVListHeaderDefaultHeightMin,
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
                    stream: _partListBloc.partPerPage,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return DropdownButton(
                        value: snapshot.data,
                        hint:
                            Text(Localization.of(context).partListItemPerPage),
                        items: getDropDownMenuElementPerPage(),
                        onChanged: (value) {
                          _partListBloc.setItemsPerPage(value);
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
            return PartWidget(parts[i]);
          },
          childCount: parts.length,
        ),
      ),
    );

    if (showOptions) {
      slivers.add(
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Center(
                child: FlatButton(
                  onPressed: null,
                  child: Text(Localization.of(context).partListLoadMore),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return CustomScrollView(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      slivers: slivers,
    );
  }
}
