import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_list_bloc.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:cv/src/widgets/profile_widget.dart';
import 'package:cv/src/widgets/sliver_delagate.dart';
import 'package:cv/src/widgets/sort_box_widget.dart';
import 'package:cv/src/widgets/sort_dialog_widget.dart';
import 'package:cv/src/widgets/sort_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileListWidget extends StatelessWidget {
  const ProfileListWidget({
    Key key,
    this.fromUserModel,
    this.fromSearch,
    this.showOptions = false,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key);

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

class _ProfileListError extends StatelessWidget {
  _ProfileListError(this.error,
      {this.showOptions = false,
      this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final Object error;

  final bool showOptions;

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

class _ProfileListLoading extends StatelessWidget {
  _ProfileListLoading(this.count,
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

class _ProfileListFromUserModel extends StatelessWidget {
  _ProfileListFromUserModel(this.userModel,
      {this.showOptions = false,
      this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

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
          return _ProfileListError(
            snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _ProfileList(
            snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        }
        return _ProfileListLoading(
          userModel.profileIds.length,
          scrollDirection: this.scrollDirection,
          shrinkWrap: this.shrinkWrap,
          physics: this.physics,
        );
      },
    );
  }
}

class _ProfileListFromSearch extends StatelessWidget {
  _ProfileListFromSearch(this.search,
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
    ProfileListBloc profileListBloc = BlocProvider.of<ProfileListBloc>(context);
    profileListBloc.fetchProfiles(search);

    return StreamBuilder<List<ProfileModel>>(
      stream: profileListBloc.profilesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProfileModel>> snapshot) {
        if (snapshot.hasError) {
          return _ProfileListError(
            snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _ProfileList(
            snapshot.data,
            showOptions: showOptions,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        }
        return _ProfileListLoading(
          1,
          scrollDirection: this.scrollDirection,
          shrinkWrap: this.shrinkWrap,
          physics: this.physics,
        );
      },
    );
  }
}

class _ProfileList extends StatelessWidget {
  _ProfileList(this.profileModels,
      {this.showOptions = false,
      this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

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

    List<Widget> slivers = [];

    if (showOptions) {
      slivers.add(
        SliverPersistentHeader(
          pinned: false,
          delegate: SliverHeaderDelegate(
            maxHeight: kCVListHeaderDefaultHeightMax,
            minHeight: kCVListHeaderDefaultHeightMin,
            child: Container(
              color: Colors.transparent,
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
            ),
          ),
        ),
      );
    }

    slivers.add(
      SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int i) {
            return ProfileWidget(profileModel: profileModels[i]);
          },
          childCount: profileModels.length,
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
                  child: Text(Localization.of(context).profileListLoadMore),
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
