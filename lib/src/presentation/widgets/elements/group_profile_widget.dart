import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// [GroupProfileWidget] is an [GroupWidget] for profile display purpose
class GroupProfileWidget extends GroupWidget {
  GroupProfileWidget(
      {Key key, String groupId, GroupEntity group, GroupBloc groupBloc})
      : super(key: key, groupId: groupId, group: group, groupBloc: groupBloc);

  @override
  State<StatefulWidget> createState() => _GroupProfileWidgetState();
}

class _GroupProfileWidgetState extends GroupWidgetState<GroupProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupBloc, GroupState>(
      bloc: groupBloc,
      builder: (BuildContext context, GroupState state) {
        if (state is GroupLoaded) {
          GroupEntity group;
          if (group.type == kCVGroupTypeListHorizontal) {
            return _GroupHorizontal(group: group);
          } else if (group.type == kCVGroupTypeListVertical) {
            return _GroupVertical(group: group);
          } else {
            return ErrorRow(error: NotImplementedYetError());
          }
        }
        return ErrorRow(error: NotImplementedYetError());
      },
    );
  }
}

class _GroupHorizontal extends StatelessWidget {
  const _GroupHorizontal({
    @required this.group,
  }) : assert(group != null);

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppStyles.groupHorizontalPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                group.name.toUpperCase(),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                child: Text(CVLocalizations.of(context).groupWidgetDetails),
                onPressed: () => navigateToGroup(context, group: group),
              ),
            ],
          ),
        ),
        Container(
          height: AppStyles.entryHorizontalListHeight,
          child: SimpleEntryListProfile(
            entryIds: group.entryIds,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }
}

class _GroupVertical extends StatelessWidget {
  const _GroupVertical({
    @required this.group,
  }) : assert(group != null);

  final GroupEntity group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppStyles.groupHorizontalPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                group.name.toUpperCase(),
                style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.bold),
              ),
              FlatButton(
                child: Text(CVLocalizations.of(context).groupWidgetDetails),
                onPressed: () => navigateToGroup(context, group: group),
              ),
            ],
          ),
        ),
        Card(
          elevation: 2.0,
          child: SimpleEntryListProfile(
            entryIds: group.entryIds,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
          ),
        ),
      ],
    );
  }
}
