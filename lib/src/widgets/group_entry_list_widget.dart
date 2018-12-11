import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_list_bloc.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/entry_widget.dart';
import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:flutter/material.dart';

class EntryListWidget extends StatelessWidget {
  EntryListWidget(this.groupModel);

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    EntryListBloc entryListBloc = BlocProvider.of<EntryListBloc>(context);
    entryListBloc.fetchGroupEntries(groupModel.id);

    return StreamBuilder<List<EntryModel>>(
      stream: entryListBloc.entriesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<EntryModel>> snapshot) {
        if (snapshot.hasError) {
          return _buildError(context, snapshot.error);
        } else if (snapshot.hasData) {
          return _buildEntries(context, snapshot.data);
        } else {
          return _buildLoadingEntries(context);
        }
      },
    );
  }

  Widget _buildLoadingEntries(BuildContext context) {
    List<Widget> _entryWidgets = [];
    int count = groupModel.entryIds.length;

    if (groupModel.type == "horizontal") {
      for (int i = 0; i < count; i++) {
        _entryWidgets.add(
          Card(
            elevation: 2.0,
            child: Container(
              height: 75.0,
              width: 300.0,
              padding: const EdgeInsets.all(20.0),
              child: LoadingShadowContent(
                numberOfTitleLines: 1,
                numberOfContentLines: 4,
              ),
            ),
          ),
        );
      }
      return ListView(
        scrollDirection: Axis.horizontal,
        children: _entryWidgets,
      );
    } else {
      for (int i = 0; i < count; i++) {
        _entryWidgets.add(LoadingShadowContent(
          numberOfTitleLines: 0,
          numberOfContentLines: 1,
        ));
      }
      return Column(
        children: _entryWidgets,
      );
    }
  }

  Widget _buildEntries(BuildContext context, List<EntryModel> entryModels) {
    List<Widget> _entryWidgets = [];

    if (groupModel.type == "horizontal") {
      entryModels.forEach((EntryModel entryModel) {
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
      return ListView(
        scrollDirection: Axis.horizontal,
        children: _entryWidgets,
      );
    } else {
      entryModels.forEach((EntryModel entryModel) {
        _entryWidgets.add(Container(
          padding: EdgeInsets.symmetric(vertical: 5.0),
          child: EntryWidget(entryModel),
        ));
      });
      return Column(
        children: _entryWidgets,
      );
    }
  }

  Widget _buildError(BuildContext context, error) {
    if (groupModel.type == "horizontal") {
      return ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          CardError(
            height: 75.0,
            width: 200.0,
            message: translateError(context, error),
          ),
        ],
      );
    } else {
      return Column(
        children: <Widget>[
          ErrorContent(translateError(context, error)),
        ],
      );
    }
  }
}
