import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_list_bloc.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:cv/src/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileListWidget extends StatelessWidget {
  ProfileListWidget({
    Key key,
    this.fromUserModel,
    this.fromSearch,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : super(key: key);

  final UserModel fromUserModel;
  final Object fromSearch;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    if (fromUserModel != null) {
      return _ProfileListFromUserModel(
        fromUserModel,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    } else if (fromSearch != null) {
      return _ProfileListFromSearch(
        fromSearch,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    }
    return ErrorContent("Not supported");
  }
}

class _ProfileListError extends StatelessWidget {
  _ProfileListError(this.error,
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
      {this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final UserModel userModel;

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
      {this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final Object search;

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
      {this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final List<ProfileModel> profileModels;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: profileModels.length,
      itemBuilder: (BuildContext context, int i) {
        return ProfileWidget(profileModels[i]);
      },
    );
  }
}
