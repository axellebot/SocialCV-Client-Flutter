import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/commons/api_values.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/entry_list_profile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/group_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

class GroupProfileWidget extends GroupWidget {
  GroupProfileWidget(
      {Key key, String groupId, GroupViewModel group, GroupBloc groupBloc})
      : super(key: key, groupId: groupId, group: group, groupBloc: groupBloc);

  @override
  State<StatefulWidget> createState() => _GroupProfileWidgetState();
}

class _GroupProfileWidgetState extends GroupWidgetState<GroupProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupEvent, GroupState>(
      bloc: groupBloc,
      builder: (BuildContext context, GroupState state) {
        if (state is GroupLoaded) {
          GroupViewModel group;
          if (group.type == kCVGroupTypeListHorizontal) {
            return _GroupHorizontal(group: group);
          } else if (group.type == kCVGroupTypeListVertical) {
            return _GroupVertical(group: group);
          } else {
            return ErrorContent(
                message: CVLocalizations.of(context).notSupported);
          }
        }
        return Container();
      },
    );
  }
}

class _GroupHorizontal extends StatelessWidget {
  const _GroupHorizontal({
    @required this.group,
  }) : assert(group != null);

  final GroupViewModel group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.groupPadding),
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
        Container(
          height: AppDimensions.horizontalEntryListHeight,
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

  final GroupViewModel group;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.groupPadding),
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
