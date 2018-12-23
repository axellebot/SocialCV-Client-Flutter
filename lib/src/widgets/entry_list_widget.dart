import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_list_bloc.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/utils/utils.dart';
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
      return _EntryListFromGroup(
        fromGroupModel,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    } else if (fromSearch != null) {
      return _EntryListFromSearch(
        fromSearch,
        scrollDirection: this.scrollDirection,
        shrinkWrap: this.shrinkWrap,
        physics: this.physics,
      );
    }
    return ErrorContent("Not supported");
  }
}

class _EntryListFromGroup extends StatelessWidget {
  _EntryListFromGroup(this.groupModel,
      {this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final GroupModel groupModel;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    EntryListBloc entryListBloc = BlocProvider.of<EntryListBloc>(context);
    entryListBloc.fetchGroupEntries(groupModel.id);

    return StreamBuilder<List<EntryModel>>(
      stream: entryListBloc.entriesStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<EntryModel>> snapshot) {
        if (snapshot.hasError) {
          return _EntryListError(
            snapshot.error,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else if (snapshot.hasData) {
          return _EntryList(
            snapshot.data,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        } else {
          return _EntryListLoading(
            groupModel.entryIds.length,
            scrollDirection: this.scrollDirection,
            shrinkWrap: this.shrinkWrap,
            physics: this.physics,
          );
        }
      },
    );
  }
}

class _EntryListFromSearch extends StatelessWidget {
  _EntryListFromSearch(this.search,
      {this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final Object search;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    return ErrorContent("Not Implemented Yet");
  }
}

class _EntryListError extends StatelessWidget {
  _EntryListError(this.error,
      {this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final Object error;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
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
}

class _EntryListLoading extends StatelessWidget {
  _EntryListLoading(this.count,
      {this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final int count;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
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
}

class _EntryList extends StatelessWidget {
  _EntryList(this.entryModels,
      {this.scrollDirection = Axis.vertical,
      this.shrinkWrap = false,
      this.physics});

  final List<EntryModel> entryModels;

  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  @override
  Widget build(BuildContext context) {
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
