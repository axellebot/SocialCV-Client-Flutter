import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_list_bloc.dart';
import 'package:cv/src/commons/api_values.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/localizations/cv_localization.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/utils/navigation.dart';
import 'package:cv/src/widgets/entry_list_widget.dart';
import 'package:cv/src/widgets/error_widget.dart';
import 'package:flutter/material.dart';

class GroupWidget extends StatelessWidget {
  const GroupWidget({
    Key key,
    @required this.groupModel,
  }) : super(key: key);

  final GroupModel groupModel;

  @override
  Widget build(BuildContext context) {
    if (groupModel.type == kCVGroupTypeListHorizontal) {
      return _GroupHorizontal(groupModel: groupModel);
    } else if (groupModel.type == kCVGroupTypeListVertical) {
      return _GroupVertical(groupModel: groupModel);
    } else {
      return ErrorContent(message: CVLocalizations.of(context).notSupported);
    }
  }
}

class _GroupHorizontal extends StatelessWidget {
  const _GroupHorizontal({
    @required this.groupModel,
  }) : assert(groupModel != null);

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
                child: Text(CVLocalizations.of(context).groupWidgetDetails),
                onPressed: () => navigateToGroup(context, groupModel.id),
              ),
            ],
          ),
        ),
        Container(
          height: kCVHorizontalEntryListHeight,
          child: BlocProvider(
            bloc: EntryListBloc(),
            child: EntryListWidget(
              fromGroupModel: groupModel,
              showOptions: false,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _GroupVertical extends StatelessWidget {
  const _GroupVertical({
    @required this.groupModel,
  }) : assert(groupModel != null);

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
                child: Text(CVLocalizations.of(context).groupWidgetDetails),
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
              showOptions: false,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
            ),
          ),
        ),
      ],
    );
  }
}
