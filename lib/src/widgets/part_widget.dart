import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_list_bloc.dart';
import 'package:cv/src/blocs/group_list_bloc.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/group_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:flutter/material.dart';

class PartWidget extends StatelessWidget {
  PartWidget(this.partModel);

  final PartModel partModel;

  @override
  Widget build(BuildContext context) {
    GroupListBloc _groupListBloc = BlocProvider.of<GroupListBloc>(context);
    _groupListBloc.fetchPartGroups(partModel.id);

    return StreamBuilder<List<GroupModel>>(
      stream: _groupListBloc.groupsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<GroupModel>> snapshot) {
        List<Widget> _widgets = [];
        if (snapshot.hasError) {
          return CardError(translateError(context, snapshot.error));
        } else if (snapshot.hasData) {
          List<GroupModel> _groupModels = snapshot.data;
          _groupModels.forEach((GroupModel _groupModel) {
            _widgets.add(
              BlocProvider<EntryListBloc>(
                bloc: EntryListBloc(),
                child: GroupWidget(_groupModel),
              ),
            );
          });

          return Column(
            children: _widgets,
          );
        }
        partModel.groupIds.forEach((String groupId) {
          _widgets.add(LoadingShadowContent(
            numberOfTitleLines: 1,
            numberOfContentLines: 4,
          ));
        });

        return Column(
          children: _widgets,
        );
      },
    );
  }
}
