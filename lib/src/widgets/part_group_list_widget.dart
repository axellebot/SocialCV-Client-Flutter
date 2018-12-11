import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/group_list_bloc.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/group_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:flutter/material.dart';

class PartGroupListWidget extends StatelessWidget {
  PartGroupListWidget(this.partModel);

  final PartModel partModel;

  @override
  Widget build(BuildContext context) {
    GroupListBloc _groupListBloc = BlocProvider.of<GroupListBloc>(context);
    _groupListBloc.fetchPartGroups(partModel.id);

    return StreamBuilder<List<GroupModel>>(
      stream: _groupListBloc.groupsStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<GroupModel>> snapshot) {
        if (snapshot.hasError) {
          return _buildError(context, snapshot.error);
        } else if (snapshot.hasData) {
          return _buildGroups(context, snapshot.data);
        }
        return _buildLoadingGroups(context);
      },
    );
  }

  Widget _buildLoadingGroups(BuildContext context) {
    List<Widget> _widgets = [];
    int count = partModel.groupIds.length;

    for (int i = 0; i < count; i++) {
      _widgets.add(LoadingShadowContent(
        numberOfTitleLines: 1,
        numberOfContentLines: 3,
      ));
    }

    return Column(
      children: _widgets,
    );
  }

  Widget _buildGroups(BuildContext context, List<GroupModel> groupModels) {
    List<Widget> _widgets = [];

    groupModels.forEach((GroupModel groupModel) {
      _widgets.add(GroupWidget(groupModel));
    });

    return Column(
      children: _widgets,
    );
  }

  Widget _buildError(BuildContext context, error) {
    return CardError(message: translateError(context, error));
  }
}
