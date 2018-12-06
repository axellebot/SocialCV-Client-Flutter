import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_group_bloc.dart';
import 'package:cv/src/models/profile_group_model.dart';
import 'package:flutter/material.dart';

class ProfileGroup extends StatelessWidget {
  ProfileGroup(this.profileGroupId);

  final String profileGroupId;

  @override
  Widget build(BuildContext context) {
    ProfileGroupBloc _profileGroupBloc =
        BlocProvider.of<ProfileGroupBloc>(context);

    _profileGroupBloc.fetchProfileGroup(profileGroupId);

    return StreamBuilder<ProfileGroupModel>(
      stream: _profileGroupBloc.profileGroupStream,
      builder:
          (BuildContext context, AsyncSnapshot<ProfileGroupModel> snapshot) {
        if (snapshot.hasData) {
          ProfileGroupModel profileGroupModel = snapshot.data;
          List<Widget> _entryWidgets;
//          profileGroupModel.entryIds.forEach((String id))
          return Card(
            child: Column(
              children: <Widget>[
                Text(profileGroupModel.name),
                Text(profileGroupModel.toString()),
              ],
            ),
          );
        }
        return Card(
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(),
              Text("Loading profile group $profileGroupId"),
            ],
          ),
        );
      },
    );
  }
}
