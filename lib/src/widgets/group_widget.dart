import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_list_bloc.dart';
import 'package:cv/src/commons/paths.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/widgets/entry_widget.dart';
import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:flutter/material.dart';

class GroupWidget extends StatelessWidget {
  GroupWidget(this.groupModel);

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    EntryListBloc _entryListBloc = BlocProvider.of<EntryListBloc>(context);
    _entryListBloc.fetchGroupEntries(groupModel.id);

    return StreamBuilder<List<EntryModel>>(
        stream: _entryListBloc.entriesStream,
        builder:
            (BuildContext context, AsyncSnapshot<List<EntryModel>> snapshot) {
          List<Widget> _entryWidgets = [];

          if (snapshot.hasError) {
            return ErrorContent(translateError(context, snapshot.error));
          } else if (snapshot.hasData) {
            List<EntryModel> entries = snapshot.data;

            if (groupModel.type == "horizontal") {
              entries.forEach((EntryModel entryModel) {
                _entryWidgets.add(
                  Card(
                    elevation: 2.0,
                    child: Container(
                      height: 75.0,
                      width: 300.0,
                      padding: const EdgeInsets.all(20.0),
                      child: EntryWidget(entryModel),
                    ),
                  ),
                );
              });
            } else {
              entries.forEach((EntryModel entryModel) {
                _entryWidgets.add(Container(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: EntryWidget(entryModel),
                ));
              });
            }
          } else {
            groupModel.entryIds.forEach((String groupId) {
              _entryWidgets.add(LoadingShadowContent(
                numberOfTitleLines: 1,
                numberOfContentLines: 4,
              ));
            });
          }
          if (groupModel.type == "horizontal") {
            return _buildGroupHorizontal(context, groupModel.id, _entryWidgets);
          } else {
            return _buildGroupDefault(context, groupModel.id, _entryWidgets);
          }
        });
  }

  Widget _buildGroupDefault(
      BuildContext context, String groupId, List<Widget> _entryWidgets) {
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
                    .pushNamed(kPathGroups + '/${groupId ?? ""}'),
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
      BuildContext context, String groupId, List<Widget> _entryWidgets) {
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
                    .pushNamed(kPathGroups + '/${groupId ?? ""}'),
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
