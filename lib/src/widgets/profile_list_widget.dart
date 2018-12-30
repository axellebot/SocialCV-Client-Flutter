import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_list_bloc.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/error_widget.dart';
import 'package:cv/src/widgets/loading_widget.dart';
import 'package:cv/src/widgets/profile_widget.dart';
import 'package:cv/src/widgets/sort_box_widget.dart';
import 'package:cv/src/widgets/sort_dialog_widget.dart';
import 'package:cv/src/widgets/sort_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// A widget to list all profiles from [UserModel] or from a search
class ProfileListWidget extends StatelessWidget {
  const ProfileListWidget({
    Key key,
    this.fromUserModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(fromUserModel != null || fromSearch != null),
        super(key: key);

  final UserModel fromUserModel;
  final Object fromSearch;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (fromUserModel != null) {
      return _ProfileListFromUserModel(
        fromUserModel,
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
        error: Localization.of(context).notYetImplemented,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    }
  }
}

class _ProfileListFromUserModel extends StatelessWidget {
  _ProfileListFromUserModel(
    this.userModel, {
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  });

  final UserModel userModel;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    ProfileListBloc profileListBloc = BlocProvider.of<ProfileListBloc>(context);
    profileListBloc.fetchAccountProfiles();

    return StreamBuilder<List<ProfileModel>>(
      stream: profileListBloc.profilesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProfileModel>> snapshot) {
        if (snapshot.hasError) {
          return ErrorList(
            error: snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _ProfileList(
            profileModels: snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else {
          return LoadingList(
            count: userModel.profileIds.length,
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

    return StreamBuilder<List<ProfileModel>>(
      stream: profileListBloc.profilesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProfileModel>> snapshot) {
        if (snapshot.hasError) {
          return ErrorList(
            error: snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _ProfileList(
            profileModels: snapshot.data,
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
    @required this.profileModels,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : assert(profileModels != null);

  final List<ProfileModel> profileModels;

  final bool showOptions;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    ProfileListBloc _profileListBloc =
        BlocProvider.of<ProfileListBloc>(context);

    final List<SortListItem> sortItems = <SortListItem>[
      SortListItem(field: "title", title: "Title", value: SortState.NoSort)
    ];

    return ListView.builder(
      scrollDirection: this.scrollDirection,
      shrinkWrap: this.shrinkWrap,
      physics: this.physics,
      itemCount: showOptions ? profileModels.length + 2 : profileModels.length,
      itemBuilder: (BuildContext context, int i) {
        if (showOptions) {
          if (i == 0) {
            return Container(
              height: kCVListHeaderDefaultHeightMax,
              color: Colors.transparent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    icon: Icon(Icons.sort_by_alpha),
                    tooltip: Localization.of(context).profileListSorting,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return SortDialog(
                            title: Text(
                                Localization.of(context).profileListSorting),
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
                        hint:
                            Text(Localization.of(context).partListItemPerPage),
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
          if (i == profileModels.length) {
            return Center(
              child: FlatButton(
                onPressed: null,
                child: Text(Localization.of(context).profileListLoadMore),
              ),
            );
          }
        }
        return ProfileWidget(profileModel: profileModels[i]);
      },
    );
  }
}
