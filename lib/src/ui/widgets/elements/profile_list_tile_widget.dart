import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/profile_list_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/profile_tile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_box_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_dialog_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/sort_list_tile_widget.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';

/// [SimpleProfileListProfile] is a dummy widget that use [profileIds] or [profiles] or
/// [profileBlocs] to create a list of [ProfileTile]
class SimpleProfileListProfile extends StatelessWidget {
  final List<String> profileIds;
  final List<ProfileViewModel> profiles;
  final List<ProfileBloc> profileBlocs;

  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  const SimpleProfileListProfile({
    Key key,
    this.profileIds,
    this.profiles,
    this.profileBlocs,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(profileIds != null && profiles == null && profileBlocs == null),
        assert(profileIds == null && profiles != null && profileBlocs == null),
        assert(profileIds == null && profiles == null && profileBlocs != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemCount;
    IndexedWidgetBuilder itemBuilder;

    if (profileIds != null && profileIds.isNotEmpty) {
      itemCount = profileIds.length;
      itemBuilder = (BuildContext context, int index) =>
          ProfileTile(profileId: profileIds[index]);
    } else if (profiles != null && profiles.isNotEmpty) {
      itemCount = profiles.length;
      itemBuilder = (BuildContext context, int index) =>
          ProfileTile(profile: profiles[index]);
    } else if (profileBlocs != null && profileBlocs.isNotEmpty) {
      itemCount = profileBlocs.length;
      itemBuilder = (BuildContext context, int index) =>
          ProfileTile(profileBloc: profileBlocs[index]);
    }

    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

/// [ComplexProfileListProfile] is a clever widget that use [parentProfileId] or
/// [ownerId] or [profileListBloc] to display a list of [ProfileProfileWidget]
class ComplexProfileListProfile extends ProfileListWidget {
  /// Search, filter and sort options
  final bool showOptions;

  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  ComplexProfileListProfile({
    Key key,
    String parentUserId,
    String ownerId,
    ProfileListBloc profileListBloc,

    /// Options
    this.showOptions = false,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : super(
          key: key,
          parentUserId: parentUserId,
          ownerId: ownerId,
          profileListBloc: profileListBloc,
        );

  @override
  State<StatefulWidget> createState() => _ProfileListProfileState();
}

class _ProfileListProfileState
    extends ProfileListWidgetState<ComplexProfileListProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileListEvent, ProfileListState>(
      bloc: widget.profileListBloc,
      builder: (BuildContext context, ProfileListState state) {
        if (state is ProfileListLoading) {
          return LoadingList(
            count: state.count,
            scrollDirection: widget.scrollDirection,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
          );
        } else if (state is ProfileListLoaded) {
          final List<SortListItem> sortItems = <SortListItem>[
            SortListItem(field: 'name', title: 'Name', value: SortState.NoSort)
          ];

          final sortRow = Row(
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
                            CVLocalizations.of(context).profileListSorting),
                        sortItems: sortItems,
                      );
                    },
                  );
                },
              ),
              DropdownButton(
                value: null,
                hint: Text(CVLocalizations.of(context).profileListItemPerPage),
                items: getDropDownMenuElementPerPage(),
                onChanged: (value) {},
              )
            ],
          );

          return ListView(
            scrollDirection: widget.scrollDirection,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
            children: <Widget>[
              if (widget.showOptions) sortRow,
              for (var profile in state.elements) ProfileTile(profile: profile),
              if (widget.showOptions)
                Center(
                  child: FlatButton(
                    onPressed: null,
                    child:
                        Text(CVLocalizations.of(context).profileListLoadMore),
                  ),
                ),
            ],
          );
        } else if (state is ProfileListFailure) {
          return ErrorList(
            error: CVLocalizations.of(context).notSupported,
            scrollDirection: widget.scrollDirection,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
          );
        }
        return Container();
      },
    );
  }
}
