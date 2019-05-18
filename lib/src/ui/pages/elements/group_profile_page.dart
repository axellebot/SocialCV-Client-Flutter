import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/entry_profile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/group_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';

class GroupPage extends GroupWidget {
  GroupPage(
      {Key key, String groupId, GroupViewModel group, GroupBloc groupBloc})
      : super(key: key, groupId: groupId, group: group, groupBloc: groupBloc);

  @override
  State<StatefulWidget> createState() => _GroupPageState();
}

class _GroupPageState extends GroupWidgetState<GroupPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupEvent, GroupState>(
      bloc: groupBloc,
      builder: (BuildContext context, GroupState state) {
        if (state is GroupLoading) {
          return Scaffold(
            appBar: AppBar(
              title: LoadingShadowContent(
                numberOfTitleLines: 1,
                numberOfContentLines: 0,
              ),
            ),
            body: SingleChildScrollView(
              child: SingleChildScrollView(
                child: LoadingShadowContent(
                  numberOfContentLines: 2,
                  padding: EdgeInsets.all(10.0),
                ),
              ),
            ),
          );
        } else if (state is GroupLoaded) {
          var model = state.element;
          return Scaffold(
            appBar: AppBar(title: Text(model.name)),
            body: ListView.builder(
              itemCount: model.entryIds.length,
              itemBuilder: (BuildContext context, int index) =>
                  EntryProfileWidget(entryId: model.entryIds[index]),
            ),
          );
        }
        return Container();
      },
    );
  }
}
