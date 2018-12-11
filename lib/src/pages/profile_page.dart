import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/part_list_bloc.dart';
import 'package:cv/src/blocs/profile_bloc.dart';
import 'package:cv/src/commons/logger.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/widgets/arc_banner_image_widget.dart';
import 'package:cv/src/widgets/initial_circle_avatar_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:cv/src/widgets/profile_part_list_widget.dart';
import 'package:flutter/material.dart';

// TODO : Build owner interraction with ProfileModel.owner #

class ProfilePage extends StatelessWidget {
  ProfilePage(this.profileId);

  final String profileId;

  @override
  Widget build(BuildContext context) {
    logger.info('Building ProfilePage');
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.fetchProfileDetails(profileId);
    return Stack(
      children: <Widget>[
        _buildProgressBar(context),
        _buildProfile(context),
        Positioned(
          top: 0.0,
          left: 0.0,
          right: 0.0,
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
          ),
        ),
      ],
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);
    return StreamBuilder<bool>(
      stream: _profileBloc.isFetchingProfileStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return LinearProgressIndicator();
        }
        return Container();
      },
    );
  }

  Widget _buildProfile(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildHeader(context),
          _buildMain(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    var textTheme = Theme.of(context).textTheme;

    return StreamBuilder<ProfileModel>(
      stream: _profileBloc.profileStream,
      builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
        Widget titleWidget = LoadingShadowContent(
          numberOfTitleLines: 1,
          numberOfContentLines: 0,
        );

        Widget subtitleWidget = LoadingShadowContent(
          numberOfTitleLines: 1,
          numberOfContentLines: 0,
        );

        Widget avatarWidget = InitialCircleAvatar(
          elevation: 2.0,
          backgroundImage: AssetImage("images/default-avatar.png"),
          radius: 75.0,
        );

        Widget bannerWidget =
            ArcBannerImage(AssetImage("images/default-banner.jpg"));

        if (snapshot.hasData) {
          ProfileModel profileModel = snapshot.data;
          titleWidget = Text(
            profileModel.title,
            style: textTheme.title,
          );
          subtitleWidget = Text(
            profileModel.subtitle,
            style: textTheme.subtitle,
          );
          avatarWidget = InitialCircleAvatar(
            text: profileModel.title,
            elevation: 2.0,
            backgroundImage: NetworkImage(profileModel.picture),
            radius: 75.0,
          );
          bannerWidget = ArcBannerImage(NetworkImage(profileModel.cover));
        }

        var profileInfo = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: titleWidget,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: subtitleWidget,
            ),
          ],
        );
        return Stack(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 68.0),
              child: bannerWidget,
            ),
            Positioned(
              bottom: 0.0,
              left: 16.0,
              right: 16.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: avatarWidget,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: profileInfo,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildMain(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    return StreamBuilder<ProfileModel>(
      stream: _profileBloc.profileStream,
      builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
        if (snapshot.hasError) {
          return Text(translateError(context, snapshot.error));
        } else if (snapshot.hasData) {
          return _buildPartList(context, snapshot.data);
        }
        return CircularProgressIndicator();
      },
    );
  }

  Widget _buildPartList(BuildContext context, ProfileModel profileModel) {
    return BlocProvider<PartListBloc>(
      bloc: PartListBloc(),
      child: ProfilePartListWidget(profileModel),
    );
  }
}
