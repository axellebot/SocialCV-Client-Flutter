import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_group_bloc.dart';
import 'package:cv/src/blocs/profile_part_bloc.dart';
import 'package:cv/src/models/profile_part_model.dart';
import 'package:cv/src/widgets/profile_group_widget.dart';
import 'package:flutter/material.dart';

class ProfilePart extends StatelessWidget {
  ProfilePart(this.profilePartId);

  final String profilePartId;

  @override
  Widget build(BuildContext context) {
    ProfilePartBloc _profilePartBloc =
        BlocProvider.of<ProfilePartBloc>(context);
    _profilePartBloc.fetchProfilePart(profilePartId);

    return StreamBuilder<ProfilePartModel>(
      stream: _profilePartBloc.profileStream,
      builder:
          (BuildContext context, AsyncSnapshot<ProfilePartModel> snapshot) {
        if (snapshot.hasData) {
          ProfilePartModel profilePartModel = snapshot.data;
          List<Widget> _groupWidgets = [];
          profilePartModel.groupIds.forEach((String groupId) {
            _groupWidgets.add(BlocProvider<ProfileGroupBloc>(
              bloc: ProfileGroupBloc(),
              child: ProfileGroup(groupId),
            ));
          });
          return Card(
            child: Column(
              children: [
                Text(profilePartModel.type),
                Column(
                  children: _groupWidgets,
                )
              ],
            ),
          );
        }
        return Card(
          child: Column(
            children: <Widget>[
              CircularProgressIndicator(),
              Text("Loading profile part $profilePartId"),
            ],
          ),
        );
      },
    );
  }
}
