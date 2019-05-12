import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/part_profile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_box_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_dialog_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_list_tile_widget.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';

/// A widget to list all parts from [PartViewModel] or from a search
class PartListWidget extends StatelessWidget {
  PartListWidget({
    Key key,
    this.fromProfileViewModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(fromProfileViewModel != null || fromSearch != null),
        super(key: key);

  final ProfileViewModel fromProfileViewModel;
  final Object fromSearch;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (fromProfileViewModel != null) {
      return _PartListFromProfile(
        profileViewModel: fromProfileViewModel,
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
      error: CVLocalizations.of(context).notYetImplemented,
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
    );
  }
}

class _PartListFromProfile extends StatelessWidget {
  _PartListFromProfile({
    @required this.profileViewModel,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(profileViewModel != null);

  final ProfileViewModel profileViewModel;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    ElementListBloc<PartViewModel> _partListBloc =
        BlocProvider.of<ElementListBloc<PartViewModel>>(context);
    _partListBloc.fetchProfileParts(profileViewModel.id);

    return StreamBuilder<List<PartViewModel>>(
      stream: _partListBloc.partsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<PartViewModel>> snapshot) {
        if (snapshot.hasError) {
          return ErrorList(
            error: snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _PartList(
            partViewModels: snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else {
          return LoadingList(
            count: profileViewModel.parts.length,
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
      error: CVLocalizations.of(context).notYetImplemented,
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
    );
  }
}

class _PartList extends StatelessWidget {
  _PartList({
    @required this.partViewModels,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(partViewModels != null);

  final List<PartViewModel> partViewModels;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    ElementListBloc<PartViewModel> _partListBloc =
        BlocProvider.of<ElementListBloc<PartViewModel>>(context);

    final List<SortListItem> sortItems = <SortListItem>[
      SortListItem(field: 'order', title: 'Order', value: SortState.NoSort),
      SortListItem(field: 'name', title: 'Name', value: SortState.NoSort)
    ];

    return ListView.builder(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      itemCount:
          showOptions ? partViewModels.length + 2 : partViewModels.length,
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
                  stream: _partListBloc.partPerPage,
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return DropdownButton(
                      value: snapshot.data,
                      hint:
                          Text(CVLocalizations.of(context).partListItemPerPage),
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
          if (i == partViewModels.length) {
            return Center(
              child: FlatButton(
                onPressed: null,
                child: Text(CVLocalizations.of(context).partListLoadMore),
              ),
            );
          }
        }
        return PartProfileWidget(part: partViewModels[i]);
      },
    );
  }
}
