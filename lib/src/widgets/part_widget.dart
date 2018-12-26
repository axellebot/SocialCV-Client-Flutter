import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/group_list_bloc.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/utils/navigation.dart';
import 'package:cv/src/widgets/group_list_widget.dart';
import 'package:flutter/material.dart';

class PartWidget extends StatelessWidget {
  PartWidget(this.partModel);

  final PartModel partModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              partModel.name.toUpperCase(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            FlatButton(
              child: Text(Localization.of(context).partWidgetDetails),
              onPressed: () => navigateToPart(context, partModel.id),
            ),
          ],
        ),
        BlocProvider<GroupListBloc>(
          bloc: GroupListBloc(),
          child: GroupListWidget(
            fromPartModel: partModel,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
          ),
        ),
      ],
    );
  }
}
