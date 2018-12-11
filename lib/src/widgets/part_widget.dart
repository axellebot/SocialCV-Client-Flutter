import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/group_list_bloc.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/widgets/part_group_list_widget.dart';
import 'package:flutter/material.dart';

class PartWidget extends StatelessWidget {
  PartWidget(this.partModel);

  final PartModel partModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GroupListBloc>(
      bloc: GroupListBloc(),
      child: PartGroupListWidget(partModel),
    );
  }
}
