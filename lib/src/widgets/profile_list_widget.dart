import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_list_bloc.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:cv/src/widgets/profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProfileListWidget extends StatelessWidget {
  ProfileListWidget({
    this.fromUserModel,
    this.fromSearch,
  });

  final UserModel fromUserModel;
  final Object fromSearch;

  @override
  Widget build(BuildContext context) {
    if (fromUserModel != null) {
      return _buildFromUserModel(context);
    } else if (fromSearch != null) {
      return _buildFromSearch(context);
    }
    return ErrorContent("Not supported");
  }

  Widget _buildFromUserModel(BuildContext context) {
    ProfileListBloc profileListBloc = BlocProvider.of<ProfileListBloc>(context);
    profileListBloc.fetchAccountProfiles();

    return StreamBuilder<List<ProfileModel>>(
      stream: profileListBloc.profilesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<ProfileModel>> snapshot) {
        if (snapshot.hasError) {
          return _buildError(context, snapshot.error);
        } else if (snapshot.hasData) {
          return _buildProfiles(context, snapshot.data);
        }
        return _buildLoadingProfiles(context);
      },
    );
  }

  Widget _buildFromSearch(BuildContext context) {
    return ErrorContent("Not Implemented Yet");
  }

  Widget _buildError(BuildContext context, Object error) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        CardError(message: translateError(context, error)),
      ],
    );
  }

  Widget _buildLoadingProfiles(BuildContext context) {
    int count = fromUserModel.profileIds.length;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
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

  Widget _buildProfiles(
      BuildContext context, List<ProfileModel> profileModels) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: profileModels.length,
      itemBuilder: (BuildContext context, int i) {
        return ProfileWidget(profileModels[i]);
      },
    );
  }
}
