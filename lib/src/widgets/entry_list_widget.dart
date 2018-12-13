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
  EntryListWidget({
    this.fromGroupModel,
    this.fromSearch,
  });

  final GroupModel fromGroupModel;
  final Object fromSearch;

  @override
  Widget build(BuildContext context) {
    if (fromGroupModel != null) {
      return _buildFromGroupModel(context);
    } else if (fromSearch != null) {
      return _buildFromSearch(context);
    }
    return ErrorContent("Not supported");
  }

  Widget _buildFromGroupModel(BuildContext context) {
    EntryListBloc entryListBloc = BlocProvider.of<EntryListBloc>(context);
    entryListBloc.fetchGroupEntries(fromGroupModel.id);

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

  Widget _buildFromSearch(context) {
    return ErrorContent("Not Implemented Yet");
  }

  Widget _buildError(BuildContext context, error) {
    if (fromGroupModel.type == "horizontal") {
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
      return ListView(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        children: <Widget>[
          ErrorContent(translateError(context, error)),
        ],
      );
    }
  }

  Widget _buildLoadingEntries(BuildContext context) {
    int count = fromGroupModel.entryIds.length;

    if (fromGroupModel.type == "horizontal") {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: count,
        itemBuilder: (BuildContext context, int i) {
          return Card(
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
          );
        },
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: count,
        itemBuilder: (BuildContext context, int i) {
          return LoadingShadowContent(
            numberOfTitleLines: 0,
            numberOfContentLines: 1,
          );
        },
      );
    }
  }

  Widget _buildEntries(BuildContext context, List<EntryModel> entryModels) {
    if (fromGroupModel.type == "horizontal") {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: entryModels.length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            elevation: 2.0,
            child: Container(
              height: 75.0,
              width: 300.0,
              padding: const EdgeInsets.all(20.0),
              child: EntryWidget(entryModels[i]),
            ),
          );
        },
      );
    } else {
      return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: entryModels.length,
        itemBuilder: (BuildContext context, int i) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: EntryWidget(entryModels[i]),
          );
        },
      );
    }
  }
}
