import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_list_bloc.dart';
import 'package:cv/src/commons/paths.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/widgets/group_entry_list_widget.dart';
import 'package:flutter/material.dart';

class GroupWidget extends StatelessWidget {
  GroupWidget(this.groupModel);

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    if (groupModel.type == "horizontal") {
      return _buildGroupHorizontal(context, groupModel);
    } else {
      return _buildGroupDefault(context, groupModel);
    }
  }

  Widget _buildGroupDefault(BuildContext context, GroupModel groupModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                groupModel.name.toUpperCase(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              FlatButton(
                child: Text(Localization.of(context).more),
                onPressed: () => Navigator.of(context)
                    .pushNamed(kPathGroups + '/${groupModel.id ?? ""}'),
              ),
            ],
          ),
        ),
        Card(
          elevation: 2.0,
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: _buildEntryList(context),
          ),
        )
      ],
    );
  }

  Widget _buildGroupHorizontal(BuildContext context, GroupModel groupModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                groupModel.name.toUpperCase(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              FlatButton(
                child: Text("More"),
                onPressed: () => Navigator.of(context)
                    .pushNamed(kPathGroups + '/${groupModel.id ?? ""}'),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(top: 0.0, bottom: 5.0),
          height: 200.0,
          child: _buildEntryList(context),
        )
      ],
    );
  }

  Widget _buildEntryList(BuildContext context) {
    return BlocProvider(
      bloc: EntryListBloc(),
      child: EntryListWidget(groupModel),
    );
  }
}
