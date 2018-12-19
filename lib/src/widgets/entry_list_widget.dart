import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_list_bloc.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/widgets/entry_widget.dart';
import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:flutter/material.dart';

class EntryListWidget extends StatelessWidget {
  EntryListWidget({
    this.fromGroupModel,
    this.fromSearch,
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  });

  final GroupModel fromGroupModel;
  final Object fromSearch;
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

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
          return _buildLoadingEntries(context, fromGroupModel.entryIds.length);
        }
      },
    );
  }

  Widget _buildFromSearch(context) {
    return ErrorContent("Not Implemented Yet");
  }

  Widget _buildError(BuildContext context, error) {
    return ListView(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      children: <Widget>[
        ErrorContent(
          translateError(context, error),
        ),
      ],
    );
  }

  Widget _buildLoadingEntries(BuildContext context, int count) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: count,
      itemBuilder: (BuildContext context, int i) {
        return Container(
          height: 75.0,
          width: 300.0,
          padding: const EdgeInsets.all(20.0),
          child: LoadingShadowContent(
            numberOfTitleLines: 1,
            numberOfContentLines: 4,
          ),
        );
      },
    );
  }

  Widget _buildEntries(BuildContext context, List<EntryModel> entryModels) {
    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: entryModels.length,
      itemBuilder: (BuildContext context, int i) {
        return EntryWidget(entryModels[i]);
      },
    );
  }
}
