import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_entry_bloc.dart';
import 'package:cv/src/models/profile_entry_model.dart';
import 'package:flutter/material.dart';

class ProfileEntry extends StatelessWidget {
  ProfileEntry(this.profileEntryId);

  final String profileEntryId;

  @override
  Widget build(BuildContext context) {
    ProfileEntryBloc _profileEntryBloc =
        BlocProvider.of<ProfileEntryBloc>(context);
    _profileEntryBloc.fetchProfileEntry(profileEntryId);

    return StreamBuilder<ProfileEntryModel>(
      stream: _profileEntryBloc.profileStream,
      builder:
          (BuildContext context, AsyncSnapshot<ProfileEntryModel> snapshot) {
        if (snapshot.hasData) {
          ProfileEntryModel profileEntryModel = snapshot.data;

          return Column(
            children: [
              _buildEntry(context, profileEntryModel),
            ],
          );
        }
        return Column(
          children: <Widget>[
            CircularProgressIndicator(),
            Text("Loading profile entry $profileEntryId"),
          ],
        );
      },
    );
  }

  Widget _buildEntry(
      BuildContext context, ProfileEntryModel profileEntryModel) {
    dynamic content = profileEntryModel.content;

    if (profileEntryModel.type == "map") {
      return Text(
          "${profileEntryModel.name ?? ""} : ${profileEntryModel.content ?? ""}");
    } else if (profileEntryModel.type == "event") {
      return Column(
        children: <Widget>[
          Text(
            "${profileEntryModel.startDate}-${profileEntryModel.endDate}",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          Row(
            children: <Widget>[
              Text(profileEntryModel.name ?? ""),
              Text(profileEntryModel.location ?? ""),
            ],
          ),
          Text(profileEntryModel.content)
        ],
      );
    } else if (profileEntryModel.type == "tag") {
      List<dynamic> tags = content;
      List<Widget> _tagWidgets = [];
      tags.forEach((dynamic tag) {
        _tagWidgets.add(Chip(label: Text(tag as String)));
      });
      return Column(
        children: <Widget>[
          Text(
            profileEntryModel.name ?? "",
            style: TextStyle(color: Theme.of(context).accentColor),
          ),
          Wrap(
            children: _tagWidgets,
          )
        ],
      );
    }
    return Text("Unhandled entry type ${profileEntryModel.type}");
  }
}
