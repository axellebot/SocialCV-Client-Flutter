import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/profile_entry_bloc.dart';
import 'package:cv/src/blocs/profile_group_bloc.dart';
import 'package:cv/src/models/profile_group_model.dart';
import 'package:cv/src/widgets/loading_widget.dart';
import 'package:cv/src/widgets/profile_entry_widget.dart';
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
        if (snapshot.hasError) {
          return Card(child: Text("Error : ${snapshot.error.toString()}"));
        } else if (snapshot.hasData) {
          return _buildGroup(context, snapshot.data);
        }
        return Loading(
          numberOfContentLines: 2,
          padding: EdgeInsets.all(10.0),
        );
      },
    );
  }

  Widget _buildGroup(
      BuildContext context, ProfileGroupModel profileGroupModel) {
    if (profileGroupModel.type == "horizontal") {
      return _buildGroupHorizontal(context, profileGroupModel);
    } else {
      return _buildGroupDefault(context, profileGroupModel);
    }
  }

  Widget _buildGroupDefault(
      BuildContext context, ProfileGroupModel profileGroupModel) {
    List<Widget> _entryWidgets = [];

    profileGroupModel.entryIds.forEach((String entryId) {
      _entryWidgets.add(
        Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: BlocProvider(
            bloc: ProfileEntryBloc(),
            child: ProfileEntry(entryId),
          ),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                profileGroupModel.name.toUpperCase(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              FlatButton(
                child: Text("More"),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Card(
          elevation: 2.0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: _entryWidgets,
            ),
          ),
        )
      ],
    );
  }

  Widget _buildGroupHorizontal(
      BuildContext context, ProfileGroupModel profileGroupModel) {
    List<Widget> _entryWidgets = [];

    profileGroupModel.entryIds.forEach((String entryId) {
      _entryWidgets.add(
        BlocProvider(
          bloc: ProfileEntryBloc(),
          child: Card(
            elevation: 2.0,
            child: Container(
              height: 75.0,
              width: 300.0,
              padding: const EdgeInsets.all(20.0),
              child: ProfileEntry(entryId),
            ),
          ),
        ),
      );
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                profileGroupModel.name.toUpperCase(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              FlatButton(
                child: Text("More"),
                onPressed: () {},
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
          height: 200.0,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: _entryWidgets,
          ),
        )
      ],
    );
  }
}
