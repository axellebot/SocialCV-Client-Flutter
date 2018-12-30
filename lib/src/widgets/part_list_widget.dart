import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/part_list_bloc.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/error_widget.dart';
import 'package:cv/src/widgets/loading_widget.dart';
import 'package:cv/src/widgets/part_widget.dart';
import 'package:cv/src/widgets/sort_box_widget.dart';
import 'package:cv/src/widgets/sort_dialog_widget.dart';
import 'package:cv/src/widgets/sort_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A widget to list all parts from [PartModel] or from a search
class PartListWidget extends StatelessWidget {
  PartListWidget({
    Key key,
    this.fromProfileModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(fromProfileModel != null || fromSearch != null),
        super(key: key);

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
        profileModel: fromProfileModel,
        showOptions: showOptions,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    } else if (fromSearch != null) {
      return _PartListFromSearch(
        search: fromSearch,
        showOptions: showOptions,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    }
    return ErrorList(
      error: Localization.of(context).notYetImplemented,
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
    );
  }
}

class _PartListFromProfile extends StatelessWidget {
  _PartListFromProfile({
    @required this.profileModel,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(profileModel != null);

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
          return ErrorList(
            error: snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _PartList(
            partModels: snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else {
          return LoadingList(
            count: profileModel.parts.length,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        }
      },
    );
  }
}

class _PartListFromSearch extends StatelessWidget {
  _PartListFromSearch({
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
      error: Localization.of(context).notYetImplemented,
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
    );
  }
}

class _PartList extends StatelessWidget {
  _PartList({
    @required this.partModels,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(partModels != null);

  final List<PartModel> partModels;

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

    return ListView.builder(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      itemCount: showOptions ? partModels.length + 2 : partModels.length,
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
                          title: Text(Localization.of(context).partListSorting),
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
                      hint: Text(Localization.of(context).partListItemPerPage),
                      items: getDropDownMenuElementPerPage(),
                      onChanged: (value) {
                        _partListBloc.setItemsPerPage(value);
                      },
                    );
                  },
                ),
              ],
            );
          }
          i--;
          if (i == partModels.length) {
            return Center(
              child: FlatButton(
                onPressed: null,
                child: Text(Localization.of(context).partListLoadMore),
              ),
            );
          }
        }
        return PartWidget(fromPartModel: partModels[i]);
      },
    );
  }
}
