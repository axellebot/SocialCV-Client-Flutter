import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/profile_tile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_box_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_dialog_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_list_tile_widget.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';

/// A widget to list all profiles from [UserViewModel] or from a search
class ProfileListWidget extends StatelessWidget {
  const ProfileListWidget({
    Key key,
    this.fromUserViewModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(fromUserViewModel != null || fromSearch != null),
        super(key: key);

  final UserViewModel fromUserViewModel;
  final Object fromSearch;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (fromUserViewModel != null) {
      return _ProfileListFromUserViewModel(
        fromUserViewModel,
        showOptions: showOptions,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    } else if (fromSearch != null) {
      return _ProfileListFromSearch(
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

class _ProfileListFromUserViewModel extends StatelessWidget {
  _ProfileListFromUserViewModel(
    this.userViewModel, {
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  });

  final UserViewModel userViewModel;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    ElementListBloc<ProfileViewModel> profileListBloc =
        BlocProvider.of<ElementListBloc<ProfileViewModel>>(context);

    profileListBloc.fetchAccountProfiles();

    return StreamBuilder<List<ProfileViewModel>>(
      stream: profileListBloc.profilesStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<ProfileViewModel>> snapshot) {
        if (snapshot.hasError) {
          return ErrorList(
            error: snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _ProfileList(
            profileViewModels: snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else {
          return LoadingList(
            count: userViewModel.profileIds.length,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        }
      },
    );
  }
}

class _ProfileListFromSearch extends StatelessWidget {
  _ProfileListFromSearch({
    this.search,
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
    ProfileListBloc profileListBloc = BlocProvider.of<ProfileListBloc>(context);
    profileListBloc.fetchProfiles(search);

    return StreamBuilder<List<ProfileViewModel>>(
      stream: profileListBloc.profilesStream,
      builder: (BuildContext context,
          AsyncSnapshot<List<ProfileViewModel>> snapshot) {
        if (snapshot.hasError) {
          return ErrorList(
            error: snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _ProfileList(
            profileViewModels: snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else {
          return LoadingList(
            count: 1,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        }
      },
    );
  }
}

class _ProfileList extends StatelessWidget {
  _ProfileList({
    @required this.profileViewModels,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(profileViewModels != null);

  final List<ProfileViewModel> profileViewModels;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    ElementListBloc<ProfileViewModel> _profileListBloc =
        BlocProvider.of<ElementListBloc<ProfileViewModel>>(context);

    final List<SortListItem> sortItems = <SortListItem>[
      SortListItem(field: 'title', title: 'Title', value: SortState.NoSort)
    ];

    return ListView.builder(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      itemCount:
          showOptions ? profileViewModels.length + 2 : profileViewModels.length,
      itemBuilder: (BuildContext context, int i) {
        if (showOptions) {
          if (i == 0) {
            return Container(
              height: AppDimensions.listHeaderDefaultHeightMax,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.sort_by_alpha),
                    tooltip: CVLocalizations.of(context).profileListSorting,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SortDialog(
                            title: Text(
                                CVLocalizations.of(context).profileListSorting),
                            sortItems: sortItems,
                          );
                        },
                      );
                    },
                  ),
                  StreamBuilder<String>(
                    stream: _profileListBloc.profilePerPage,
                    builder:
                        (BuildContext context, AsyncSnapshot<String> snapshot) {
                      return DropdownButton(
                        value: snapshot.data,
                        hint: Text(
                            CVLocalizations.of(context).partListItemPerPage),
                        items: getDropDownMenuElementPerPage(),
                        onChanged: (value) {
                          _profileListBloc.setItemsPerPage(value);
                        },
                      );
                    },
                  ),
                ],
              ),
            );
          }
          i--;
          if (i == profileViewModels.length) {
            return Center(
              child: FlatButton(
                onPressed: null,
                child: Text(CVLocalizations.of(context).profileListLoadMore),
              ),
            );
          }
        }
        return ProfileTile(profileViewModel: profileViewModels[i]);
      },
    );
  }
}
