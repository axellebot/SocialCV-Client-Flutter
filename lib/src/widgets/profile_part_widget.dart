import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_group_bloc.dart';
import 'package:cv/src/blocs/profile_part_bloc.dart';
import 'package:cv/src/models/profile_part_model.dart';
import 'package:cv/src/widgets/loading_widget.dart';
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
        if (snapshot.hasError) {
          return Text("Error ${snapshot.error.toString()}");
        } else if (snapshot.hasData) {
          ProfilePartModel profilePartModel = snapshot.data;
          return _buildPart(context, profilePartModel);
        }
        return Loading(
          numberOfContentLines: 2,
          padding: EdgeInsets.all(10.0),
        );
      },
    );
  }

  Column _buildPart(BuildContext context, ProfilePartModel profilePartModel) {
    List<Widget> _groupWidgets = [];
    profilePartModel.groupIds.forEach((String groupId) {
      _groupWidgets.add(BlocProvider<ProfileGroupBloc>(
        bloc: ProfileGroupBloc(),
        child: ProfileGroup(groupId),
      ));
    });

    return Column(
      children: _groupWidgets,
    );
  }
}
