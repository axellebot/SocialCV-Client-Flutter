import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_bloc.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:flutter/material.dart';

// TODO : Build owner interraction with ProfileModel.owner #

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('Building ProfilePage');
    return Scaffold(
      appBar: AppBar(
        title: Text(Localization.of(context).profileTitle),
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    return SafeArea(
      child: Stack(
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
          _buildProfile(context)
        ],
      ),
    );
  }

  Widget _buildProfile(BuildContext context) {
    ProfileBloc _profileBloc = BlocProvider.of<ProfileBloc>(context);

    return StreamBuilder<ProfileModel>(
      stream: _profileBloc.profileStream,
      builder: (BuildContext context, AsyncSnapshot<ProfileModel> snapshot) {
        if (snapshot.hasData) {
          return Text(snapshot.data.toString());
        } else if (snapshot.hasError) {
          return Container(child: Text("Error : ${snapshot.error}"));
        }
        return Container();
      },
    );
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
