import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_bloc.dart';
import 'package:cv/src/blocs/profile_part_bloc.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/widgets/initial_circle_avatar_widget.dart';
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

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[_buildSliverAppBar(context)];
      },
      body: Stack(
        children: <Widget>[
          StreamBuilder<bool>(
            stream: _profileBloc.isFetchingStream,
            builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
              if (snapshot.data == true) {
                return LinearProgressIndicator();
              }
              return Container();
            },
          ),
          _buildInnerBody(context),
        ],
      ),
    );
  }

  Widget _buildInnerBody(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    return StreamBuilder<ProfileModel>(
      stream: _profileBloc.profileStream,
      builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
        if (snapshot.hasData) {
          ProfileModel profile = snapshot.data;
          return Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Text(profile.title),
                        Text(profile.subtitle),
                        Wrap(children: _buildPart(context, profile.partIds))
                      ],
                    ),
                  ),
                ],
              )
            ],
          );
        } else if (snapshot.hasError) {
          return Container(child: Text("Error : ${snapshot.error}"));
        }
        return Container();
      },
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    return StreamBuilder<ProfileModel>(
      stream: _profileBloc.profileStream,
      builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
        if (snapshot.hasData) {
          ProfileModel profile = snapshot.data;

          return SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: false,
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              title: InitialCircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(profile.picture),
              ),
              background: Image.network(
                profile.cover,
                fit: BoxFit.cover,
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return SliverAppBar();
        }
        return SliverAppBar();
      },
    );
  }

  _buildPart(BuildContext context, List<String> partIds) {
    List<Widget> _partWidgets = [];

    partIds.forEach((String id) {
      _partWidgets.add(BlocProvider<ProfilePartBloc>(
        bloc: ProfilePartBloc(),
        child: ProfilePart(id),
      ));
    });
    return _partWidgets;
  }

//
//  Widget _buildSkillGroupChips(List<String> skillTags) {
//    if (skillTags == null) {
//      return Text("null");
//    }
//
//    List<Widget> _skillWidgets = [];
//    skillTags.forEach((element) {
//      _skillWidgets.add(
//        new Chip(
//          label: Text((element != null) ? element : "null"),
//        ),
//      );
//    });
//    return new Wrap(
//      spacing: widget.defaultChipSpacing, // gap between adjacent chips
//      runSpacing: widget.defaultChipSpacing, // gap between lines
//      children: _skillWidgets,
//    );
//  }
//
//  Widget _buildSkillsPart() {
//    return new Card(
//      elevation: widget.defaultElevation,
//      child: Padding(
//        padding: const EdgeInsets.all(20.0),
//        child: FutureBuilder(
//            future: repository.getSkillGroups(),
//            builder: (BuildContext context, AsyncSnapshot snapshot) {
//              if (snapshot.hasError) {
//                return Text(Localization.of(context).errorOccurred);
//              } else if (snapshot.hasData == false) {
//                return CircularProgressIndicator();
//              } else {
//                List<SkillGroup> skillGroups = snapshot.data;
//                List<Widget> skillWidgets = [];
//
//                skillGroups.forEach((skillGroup) {
//                  skillWidgets.add(
//                    Text(
//                      (skillGroup.label != null) ? skillGroup.label : "null",
//                    ),
//                  );
//                  skillWidgets.add(_buildSkillGroupChips(skillGroup.skills));
//                });
//
//                return Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  mainAxisAlignment: MainAxisAlignment.center,
//                  children: skillWidgets,
//                );
//              }
//            }),
//      ),
//    );
//  }
}
