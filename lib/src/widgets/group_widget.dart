import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_list_bloc.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/utils/navigation.dart';
import 'package:cv/src/widgets/entry_list_widget.dart';
import 'package:flutter/material.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({
    Key key,
    @required this.groupModel,
  }) : super(key: key);

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    if (groupModel.type == "horizontal") {
      return _GroupHorizontal(groupModel);
    } else {
      return _GroupVertical(groupModel);
    }
  }
}

class _GroupVertical extends StatelessWidget {
  const _GroupVertical(this.groupModel);

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kCVGroupPadding),
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
                onPressed: () => navigateToGroup(context, groupModel.id),
              ),
            ],
          ),
        ),
        Card(
          elevation: 2.0,
          child: BlocProvider(
            bloc: EntryListBloc(),
            child: EntryListWidget(
              fromGroupModel: groupModel,
              showOptions: true,
              scrollDirection: (groupModel.type == 'horizontal')
                  ? Axis.horizontal
                  : Axis.vertical,
            ),
          ),
        )
      ],
    );
  }
}

class _GroupHorizontal extends StatelessWidget {
  const _GroupHorizontal(this.groupModel);

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kCVGroupPadding),
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
                onPressed: () => navigateToGroup(context, groupModel.id),
              ),
            ],
          ),
        ),
        Container(
          height: 200.0,
          child: BlocProvider(
            bloc: EntryListBloc(),
            child: EntryListWidget(
              fromGroupModel: groupModel,
              scrollDirection: (groupModel.type == 'horizontal')
                  ? Axis.horizontal
                  : Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            ),
          ),
        )
      ],
    );
  }
}
