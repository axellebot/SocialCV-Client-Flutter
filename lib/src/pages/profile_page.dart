import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/part_bloc.dart';
import 'package:cv/src/blocs/profile_bloc.dart';
import 'package:cv/src/commons/api_values.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/localizations/cv_localization.dart';
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
          List<Widget> slivers = [];
          slivers.add(_ProfilePageAppBar());

          if (snapshot.hasError) {
            slivers.add(
              SliverToBoxAdapter(
                child:
                    ErrorCard(message: translateError(context, snapshot.error)),
              ),
            );
          } else if (snapshot.hasData) {
            ProfileModel profileModel = snapshot.data;
            if (profileModel.type == kCVProfileType1) {
              slivers.addAll([
                _ProfilePageSliver(
                  partId: profileModel.parts["main"],
                )
              ]);
            } else if (profileModel.type == kCVProfileType2) {
              slivers.addAll([
                _ProfilePageSliver(
                  partId: profileModel.parts["header"],
                ),
                _ProfilePageSliver(
                  partId: profileModel.parts["main"],
                )
              ]);
            } else if (profileModel.type == kCVProfileType3) {
              slivers.addAll([
                _ProfilePageSliver(
                  partId: profileModel.parts["side"],
                ),
                _ProfilePageSliver(
                  partId: profileModel.parts["main"],
                )
              ]);
            } else if (profileModel.type == kCVProfileType4) {
              slivers.addAll([
                _ProfilePageSliver(
                  partId: profileModel.parts["header"],
                ),
                _ProfilePageSliver(
                  partId: profileModel.parts["side"],
                ),
                _ProfilePageSliver(
                  partId: profileModel.parts["main"],
                )
              ]);
            } else {
              slivers.add(
                SliverToBoxAdapter(
                  child: ErrorCard(
                    message: CVLocalizations.of(context).notSupported,
                  ),
                ),
              );
            }
          } else {
            slivers.add(
              SliverToBoxAdapter(
                child: LoadingShadowContent(
                  numberOfContentLines: 3,
                ),
              ),
            );
          }

          return CustomScrollView(
            slivers: slivers,
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

    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      elevation: 2.0,
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
            elevation: kCVProfileAvatarElevation,
            maxRadius: kCVProfileAvatarMax,
            minRadius: kCVProfileAvatarMin,
            backgroundImage: AssetImage("images/default-avatar.png"),
          );

          Widget bannerWidget = Image.asset(
            "images/default-banner.jpg",
            fit: BoxFit.cover,
          );

          if (snapshot.hasData) {
            ProfileModel profileModel = snapshot.data;
            titleWidget = Text(
              profileModel.title,
            );
            subtitleWidget = Text(
              profileModel.subtitle,
            );
            avatarWidget = InitialCircleAvatar(
              text: profileModel.title,
              elevation: kCVProfileAvatarElevation,
              maxRadius: kCVProfileAvatarMax,
              minRadius: kCVProfileAvatarMin,
              backgroundImage: NetworkImage(profileModel.picture),
            );

            bannerWidget = Image.network(
              profileModel.cover,
              fit: BoxFit.cover,
            );
          }

          Widget profileInfo = Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titleWidget,
              subtitleWidget,
            ],
          );

          Widget backgroundWidget = Stack(
            children: [
              Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  bannerWidget,
                  // This gradient ensures that the toolbar icons are distinct
                  // against the background image.
                  const DecoratingBackground(),
                ],
              ),
              Center(heightFactor: 2, child: avatarWidget),
            ],
          );
          return FlexibleSpaceBar(
            background: backgroundWidget,
            collapseMode: CollapseMode.parallax,
            centerTitle: true,
            title: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  profileInfo,
                ],
              ),
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

class DecoratingBackground extends StatelessWidget {
  const DecoratingBackground({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.0, -1.0),
          end: Alignment(0.0, 5),
          colors: <Color>[Color(0x60000000), Color(0x00000000)],
        ),
      ),
    );
  }
}
