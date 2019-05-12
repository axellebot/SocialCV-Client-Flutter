import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/commons/api_values.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/part_profile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/profile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/initial_circle_avatar_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/utils/logger.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';

/// TODO : Build owner interaction with ProfileViewModel.owner

class ProfileProfilePage extends ProfileWidget {
  ProfileProfilePage(
      {Key key,
      String profileId,
      ProfileViewModel profile,
      ProfileBloc profileBloc})
      : super(
            key: key,
            profileId: profileId,
            profile: profile,
            profileBloc: profileBloc);

  @override
  State<StatefulWidget> createState() => _ProfileProfilePageState();
}

class _ProfileProfilePageState extends ProfileWidgetState<ProfileProfilePage> {
  @override
  Widget build(BuildContext context) {
    logger.info('Building ProfilePage');

    return BlocBuilder<ProfileEvent, ProfileState>(
      bloc: profileBloc,
      builder: (BuildContext context, ProfileState state) {
        List<Widget> slivers = [];

        if (state is ProfileLoaded) {
          slivers.add(_ProfilePageAppBar(profile: state.element));
          ProfileViewModel profile = state.element;
          if (profile.type == kCVProfileTypeMain) {
            slivers.addAll([
              PartProfileWidget(
                partId: profile.partIds.elementAt(0),
              )
            ]);
          } else if (profile.type == kCVProfileTypeHeaderMain) {
            slivers.addAll([
              PartProfileWidget(
                partId: profile.partIds.elementAt(0),
              ),
              PartProfileWidget(
                partId: profile.partIds.elementAt(1),
              )
            ]);
          } else if (profile.type == kCVProfileTypeMainSide) {
            slivers.addAll([
              PartProfileWidget(
                partId: profile.partIds.elementAt(0),
              ),
              PartProfileWidget(
                partId: profile.partIds.elementAt(1),
              )
            ]);
          } else if (profile.type == kCVProfileTypeHeaderMainSide) {
            slivers.addAll([
              PartProfileWidget(
                partId: profile.partIds.elementAt(0),
              ),
              PartProfileWidget(
                partId: profile.partIds.elementAt(1),
              ),
              PartProfileWidget(
                partId: profile.partIds.elementAt(2),
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
        } else if (state is ProfileFailure) {
          slivers.add(
            SliverToBoxAdapter(
              child: ErrorCard(message: translateError(context, state.error)),
            ),
          );
        }
        return Scaffold(
            body: CustomScrollView(
          slivers: slivers,
        ));
      },
    );
  }
}

class _ProfilePageAppBar extends StatelessWidget {
  final ProfileViewModel profile;

  _ProfilePageAppBar({@required this.profile});

  @override
  Widget build(BuildContext context) {
    Widget titleWidget = LoadingShadowContent(
      numberOfTitleLines: 1,
      numberOfContentLines: 0,
    );

    Widget subtitleWidget = LoadingShadowContent(
      numberOfTitleLines: 1,
      numberOfContentLines: 0,
    );

    Widget avatarWidget = InitialCircleAvatar(
      elevation: AppDimensions.profileAvatarElevation,
      maxRadius: AppDimensions.profileAvatarMax,
      minRadius: AppDimensions.profileAvatarMin,
      backgroundImage: AssetImage('images/default-avatar.png'),
    );

    Widget bannerWidget = Image.asset(
      'images/default-banner.jpg',
      fit: BoxFit.cover,
    );

    if (this.profile != null) {
      titleWidget = Text(
        profile.title,
      );
      subtitleWidget = Text(
        profile.subtitle,
      );
      avatarWidget = InitialCircleAvatar(
        text: profile.title,
        elevation: AppDimensions.profileAvatarElevation,
        maxRadius: AppDimensions.profileAvatarMax,
        minRadius: AppDimensions.profileAvatarMin,
        backgroundImage: NetworkImage(profile.picture.toString()),
      );

      bannerWidget = Image.network(
        profile.cover.toString(),
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
            const DecoratingBackground(),
          ],
        ),
        Center(heightFactor: 2, child: avatarWidget),
      ],
    );

    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      elevation: 2.0,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
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
          /// This gradient ensures that the toolbar icons are distinct
          /// against the background image.
          begin: Alignment(0.0, -1.0),
          end: Alignment(0.0, 5),
          colors: <Color>[Color(0x60000000), Color(0x00000000)],
        ),
      ),
    );
  }
}
