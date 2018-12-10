import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_entry_bloc.dart';
import 'package:cv/src/models/profile_entry_model.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
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
        if (snapshot.hasError) {
          return Text("Error : ${snapshot.error.toString()}");
        } else if (snapshot.hasData) {
          return _buildEntry(context, snapshot.data);
        }
        return LoadingShadowContent();
      },
    );
  }

  Widget _buildEntry(
      BuildContext context, ProfileEntryModel profileEntryModel) {
    if (profileEntryModel.type == "map") {
      return _buildEntryMap(context, profileEntryModel);
    } else if (profileEntryModel.type == "event") {
      return _buildEntryEvent(context, profileEntryModel);
    } else if (profileEntryModel.type == "tag") {
      return _buildEntryTag(context, profileEntryModel);
    } else {
      return _buildEntryDefault(profileEntryModel);
    }
  }

  Widget _buildEntryDefault(ProfileEntryModel profileEntryModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("Unhandled entry type ${profileEntryModel.type}")
      ],
    );
  }

  Widget _buildEntryMap(
      BuildContext context, ProfileEntryModel profileEntryModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text("${profileEntryModel.name ?? ""}",style: TextStyle(fontWeight:
        FontWeight.bold),),
        Expanded(
          child: Text(
            "${profileEntryModel.content ?? ""}",
            textAlign: TextAlign.end,
          ),
        )
      ],
    );
  }

  Widget _buildEntryEvent(
      BuildContext context, ProfileEntryModel profileEntryModel) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "${profileEntryModel.startDate}   ${profileEntryModel.endDate}",
              textAlign: TextAlign.start,
              style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
              child: Text(
                profileEntryModel.location ?? "",
                textAlign: TextAlign.end,
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            )
          ],
        ),
        Text(
          profileEntryModel.name ?? "",
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Expanded(
          child: Text(
            profileEntryModel.content,
            textAlign: TextAlign.justify,
          ),
        )
      ],
    );
  }

  Widget _buildEntryTag(
      BuildContext context, ProfileEntryModel profileEntryModel) {
    List<dynamic> tags = profileEntryModel.content;
    List<Widget> _tagWidgets = [];
    tags.forEach((dynamic tag) {
      _tagWidgets.add(Chip(label: Text(tag as String)));
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Text(
          profileEntryModel.name.toUpperCase() ?? "",
          style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 4.0,
          runSpacing: 0.0,
          children: _tagWidgets,
        )
      ],
    );
  }
}
