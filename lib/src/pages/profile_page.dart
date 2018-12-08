import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_bloc.dart';
import 'package:cv/src/blocs/profile_part_bloc.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/widgets/arc_banner_image.dart';
import 'package:cv/src/widgets/initial_circle_avatar_widget.dart';
import 'package:cv/src/widgets/loading_widget.dart';
import 'package:cv/src/widgets/profile_part_widget.dart';
import 'package:flutter/material.dart';

// TODO : Build owner interraction with ProfileModel.owner #

class ProfilePage extends StatelessWidget {
  ProfilePage(this.profileId);

  final String profileId;

  @override
  Widget build(BuildContext context) {
    print('Building ProfilePage');
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
        StreamBuilder<ProfileModel>(
          stream: _profileBloc.profileStream,
          builder:
              (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
            if (snapshot.hasError) {
              return Text("Error ${snapshot.error.toString()}");
            }
            if (snapshot.hasData) {
              return _buildProfile(context, snapshot.data);
            }
            return _buildProfileLoading(context);
          },
        ),
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
      stream: _profileBloc.isFetchingStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return LinearProgressIndicator();
        }
        return Container();
      },
    );
  }

  Widget _buildProfileLoading(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildHeaderLoading(context),
          _buildMainLoading(context),
        ],
      ),
    );
  }

  Widget _buildHeaderLoading(BuildContext context) {
    var profileInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Loading(
            numberOfTitleLines: 1,
            numberOfContentLines: 0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Loading(
            numberOfTitleLines: 1,
            numberOfContentLines: 0,
          ),
        ),
      ],
    );
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 68.0),
          child: ArcBannerImage(""),
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
                child: InitialCircleAvatar(
                  elevation: 2.0,
                  backgroundImage: AssetImage("images/unknown_profile.png"),
                  radius: 75.0,
                ),
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
  }

  Widget _buildMainLoading(BuildContext context) {
    return SafeArea(
      child: Column(children: <Widget>[
        Loading(
          numberOfTitleLines: 1,
          numberOfContentLines: 4,
        ),
        Loading(
          numberOfTitleLines: 1,
          numberOfContentLines: 4,
        ),
        Loading(
          numberOfTitleLines: 1,
          numberOfContentLines: 4,
        ),
      ]),
    );
  }

  Widget _buildProfile(BuildContext context, ProfileModel profileModel) {
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          _buildHeader(context, profileModel),
          _buildMain(context, profileModel),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, ProfileModel profileModel) {
    var textTheme = Theme.of(context).textTheme;

    var profileInfo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Text(
            profileModel.title,
            style: textTheme.title,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            profileModel.subtitle,
            style: textTheme.subtitle,
          ),
        ),
      ],
    );
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(bottom: 68.0),
          child: ArcBannerImage(profileModel.cover),
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
                child: InitialCircleAvatar(
                  text: profileModel.title,
                  elevation: 2.0,
                  backgroundImage: NetworkImage(profileModel.picture),
                  radius: 75.0,
                ),
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
  }

  Widget _buildMain(BuildContext context, ProfileModel profileModel) {
    return SafeArea(
      child: Column(
        children: _buildPart(context, profileModel.partIds),
      ),
    );
  }

  List<Widget> _buildPart(BuildContext context, List<String> partIds) {
    List<Widget> _partWidgets = [];

    partIds.forEach((String id) {
      _partWidgets.add(BlocProvider<ProfilePartBloc>(
        bloc: ProfilePartBloc(),
        child: ProfilePart(id),
      ));
    });
    return _partWidgets;
  }
}
