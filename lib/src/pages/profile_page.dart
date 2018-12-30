import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/part_bloc.dart';
import 'package:cv/src/blocs/profile_bloc.dart';
import 'package:cv/src/commons/api_values.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/utils/logger.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/error_widget.dart';
import 'package:cv/src/widgets/initial_circle_avatar_widget.dart';
import 'package:cv/src/widgets/loading_widget.dart';
import 'package:cv/src/widgets/part_widget.dart';
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
      body: StreamBuilder<ProfileModel>(
        stream: _profileBloc.profileStream,
        builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
          if (snapshot.hasError) {
            return CustomScrollView(
              slivers: <Widget>[
                _ProfilePageAppBar(),
                SliverToBoxAdapter(
                  child: ErrorContent(
                    message: translateError(context, snapshot.error),
                  ),
                ),
              ],
            );
          } else if (snapshot.hasData) {
            ProfileModel profileModel = snapshot.data;
            if (profileModel.type == kCVProfileType4) {
              return CustomScrollView(
                slivers: <Widget>[
                  _ProfilePageAppBar(),
                  _ProfilePageSliver(
                    partId: snapshot.data.parts["header"],
                  ),
                  _ProfilePageSliver(
                    partId: snapshot.data.parts["side"],
                  ),
                  _ProfilePageSliver(
                    partId: snapshot.data.parts["main"],
                  ),
                ],
              );
            } else {
              return CustomScrollView(
                slivers: <Widget>[
                  _ProfilePageAppBar(),
                  SliverToBoxAdapter(
                    child: ErrorCard(
                      message: Localization.of(context).notSupported,
                    ),
                  ),
                ],
              );
            }
          }
          return CustomScrollView(
            slivers: <Widget>[
              _ProfilePageAppBar(),
              SliverToBoxAdapter(
                child: LoadingShadowContent(
                  numberOfContentLines: 3,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ProfilePageAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    var textTheme = Theme.of(context).textTheme;

    return SliverAppBar(
      expandedHeight: 200,
      floating: false,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(6.0),
        child: StreamBuilder<bool>(
          stream: _profileBloc.isFetchingProfileStream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return LinearProgressIndicator();
            }
            return Container();
          },
        ),
      ),
      flexibleSpace: StreamBuilder<ProfileModel>(
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

          Widget bannerWidget = Image.asset(
            "images/default-banner.jpg",
            fit: BoxFit.cover,
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
            bannerWidget = Image.network(
              profileModel.cover,
              fit: BoxFit.cover,
            );
          }

          Widget profileInfo = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              titleWidget,
              subtitleWidget,
            ],
          );

          return FlexibleSpaceBar(
            background: bannerWidget,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                avatarWidget,
                profileInfo,
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ProfilePageSliver extends StatelessWidget {
  const _ProfilePageSliver({@required this.partId}) : assert(partId != null);

  final String partId;
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocProvider(
        bloc: PartBloc(),
        child: PartWidget(fromId: partId),
      ),
    );
  }
}
