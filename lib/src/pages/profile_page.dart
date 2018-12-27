import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/part_list_bloc.dart';
import 'package:cv/src/blocs/profile_bloc.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/arc_banner_image_widget.dart';
import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:cv/src/widgets/initial_circle_avatar_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:cv/src/widgets/part_list_widget.dart';
import 'package:flutter/material.dart';

// TODO : Build owner interaction with ProfileModel.owner

class ProfilePage extends StatelessWidget {
  const ProfilePage({
    Key key,
    @required this.profileId,
  })  : assert(profileId != null),
        super(key: key);

  final String profileId;

  @override
  Widget build(BuildContext context) {
    logger.info('Building ProfilePage');

    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);
    _profileBloc.fetchProfileDetails(profileId);

    return Scaffold(
      body: Stack(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: _profileBloc.isFetchingProfileStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return LinearProgressIndicator();
              }
              return Container();
            },
          ),
          _ProfilePageDetails(),
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
      ),
    );
  }
}

class _ProfilePageDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          _ProfilePageHeader(),
          _ProfilePageMain(),
        ],
      ),
    );
  }
}

class _ProfilePageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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

        Widget bannerWidget = ArcBannerImage(
          imageProvider: AssetImage("images/default-banner"
              ".jpg"),
        );

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
          bannerWidget =
              ArcBannerImage(imageProvider: NetworkImage(profileModel.cover));
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
}

class _ProfilePageMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    return StreamBuilder<ProfileModel>(
      stream: _profileBloc.profileStream,
      builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
        if (snapshot.hasError) {
          return ErrorContent(message: translateError(context, snapshot.error));
        } else if (snapshot.hasData) {
          return BlocProvider<PartListBloc>(
            bloc: PartListBloc(),
            child: PartListWidget(
              fromProfileModel: snapshot.data,
              scrollDirection: Axis.vertical,
            ),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
