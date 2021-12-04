import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// [SimpleGroupListProfile] is a dummy widget that use [groupIds] or [groups]
/// or [groupBlocs] to create a list of [GroupProfileWidget]
class SimpleGroupListProfile extends StatelessWidget {
  final List<String>? groupIds;
  final List<GroupEntity>? groups;
  final List<GroupBloc>? groupBlocs;

  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const SimpleGroupListProfile({
    Key? key,
    this.groupIds,
    this.groups,
    this.groupBlocs,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(groupIds != null && groups == null && groupBlocs == null),
        assert(groupIds == null && groups != null && groupBlocs == null),
        assert(groupIds == null && groups == null && groupBlocs != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    int? itemCount;
    late IndexedWidgetBuilder itemBuilder;

    if (groupIds != null && groupIds!.isNotEmpty) {
      itemCount = groupIds!.length;
      itemBuilder = (BuildContext context, int index) =>
          GroupProfileWidget(groupId: groupIds![index]);
    } else if (groups != null && groups!.isNotEmpty) {
      itemCount = groups!.length;
      itemBuilder = (BuildContext context, int index) =>
          GroupProfileWidget(group: groups![index]);
    } else if (groupBlocs != null && groupBlocs!.isNotEmpty) {
      itemCount = groupBlocs!.length;
      itemBuilder = (BuildContext context, int index) =>
          GroupProfileWidget(groupBloc: groupBlocs![index]);
    }

    return ListView.builder(
      scrollDirection: scrollDirection,
      shrinkWrap: shrinkWrap,
      physics: physics,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}

/// [ComplexGroupListProfile] is a clever widget that use [parentPartId] or [ownerId] or [groupListBloc] to display a list of [GroupProfileWidget]
class ComplexGroupListProfile extends GroupListWidget {
  /// Search, filter and sort options
  final bool showOptions;

  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const ComplexGroupListProfile({
    Key? key,
    String? parentPartId,
    String? ownerId,
    GroupListBloc? groupListBloc,

    /// Options
    this.showOptions = false,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : super(
          key: key,
          parentPartId: parentPartId,
          ownerId: ownerId,
          groupListBloc: groupListBloc,
        );

  @override
  State<StatefulWidget> createState() => _GroupListProfileState();
}

class _GroupListProfileState
    extends GroupListWidgetState<ComplexGroupListProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GroupListBloc, GroupListState>(
      bloc: widget.groupListBloc,
      builder: (BuildContext context, GroupListState state) {
        if (state is GroupListLoading) {
          return LoadingList(
            count: state.count,
            scrollDirection: widget.scrollDirection,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
          );
        } else if (state is GroupListLoaded) {
          final List<SortListItem> sortItems = <SortListItem>[
            SortListItem(field: 'name', title: 'Name', value: SortState.noSort)
          ];

          final sortRow = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.sort_by_alpha),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return SortDialog(
                        title:
                            Text(CVLocalizations.of(context)!.groupListSorting),
                        sortItems: sortItems,
                      );
                    },
                  );
                },
              ),
              DropdownButton(
                value: null,
                hint: Text(CVLocalizations.of(context)!.partListItemPerPage),
                items: getDropDownMenuElementPerPage(),
                onChanged: (dynamic value) {},
              )
            ],
          );

          return ListView(
            scrollDirection: widget.scrollDirection,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
            children: <Widget>[
              if (widget.showOptions) sortRow,
              for (var group in state.elements)
                GroupProfileWidget(group: group),
              if (widget.showOptions)
                Center(
                  child: TextButton(
                    onPressed: null,
                    child: Text(CVLocalizations.of(context)!.groupListLoadMore),
                  ),
                ),
            ],
          );
        } else if (state is GroupListFailure) {
          return ErrorList(
            error: state.error,
            scrollDirection: widget.scrollDirection,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
          );
        }
        return ErrorList(
          error: NotImplementedYetError(),
          scrollDirection: widget.scrollDirection,
          shrinkWrap: widget.shrinkWrap,
          physics: widget.physics,
        );
      },
    );
  }
}
