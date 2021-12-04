import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// [SimpleEntryListProfile] is a dummy widget that use [entryIds] or [entries]
/// or [entryBlocs] to create a list of [EntryProfileWidget]
class SimpleEntryListProfile extends StatelessWidget {
  final List<String>? entryIds;
  final List<EntryEntity>? entries;
  final List<EntryBloc>? entryBlocs;

  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const SimpleEntryListProfile({
    Key? key,
    this.entryIds,
    this.entries,
    this.entryBlocs,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(entryIds != null && entries == null && entryBlocs == null),
        assert(entryIds == null && entries != null && entryBlocs == null),
        assert(entryIds == null && entries == null && entryBlocs != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    int? itemCount;
    late IndexedWidgetBuilder itemBuilder;

    if (entryIds != null && entryIds!.isNotEmpty) {
      itemCount = entryIds!.length;
      itemBuilder = (BuildContext context, int index) =>
          EntryProfileWidget(entryId: entryIds![index]);
    } else if (entries != null && entries!.isNotEmpty) {
      itemCount = entries!.length;
      itemBuilder = (BuildContext context, int index) =>
          EntryProfileWidget(entry: entries![index]);
    } else if (entryBlocs != null && entryBlocs!.isNotEmpty) {
      itemCount = entryBlocs!.length;
      itemBuilder = (BuildContext context, int index) =>
          EntryProfileWidget(entryBloc: entryBlocs![index]);
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

/// [ComplexEntryListProfile] is a clever widget that use [parentGroupId] or [ownerId] or [entryListBloc] to display a list of [EntryProfileWidget]
class ComplexEntryListProfile extends EntryListWidget {
  /// Search, filter and sort options
  final bool showOptions;

  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics? physics;

  const ComplexEntryListProfile({
    Key? key,
    String? parentGroupId,
    String? ownerId,
    EntryListBloc? entryListBloc,

    /// Options
    this.showOptions = false,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : super(
          key: key,
          parentGroupId: parentGroupId,
          ownerId: ownerId,
          entryListBloc: entryListBloc,
        );

  @override
  State<StatefulWidget> createState() => _EntryListProfileState();
}

class _EntryListProfileState
    extends ComplexEntryListState<ComplexEntryListProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryListBloc, EntryListState>(
      bloc: widget.entryListBloc,
      builder: (BuildContext context, EntryListState state) {
        if (state is EntryListLoading) {
          return LoadingList(
            count: state.count,
            scrollDirection: widget.scrollDirection,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
          );
        } else if (state is EntryListLoaded) {
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
                            Text(CVLocalizations.of(context)!.entryListSorting),
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
              for (var entry in state.elements)
                EntryProfileWidget(entry: entry),
              if (widget.showOptions)
                Center(
                  child: TextButton(
                    onPressed: null,
                    child: Text(CVLocalizations.of(context)!.entryListLoadMore),
                  ),
                ),
            ],
          );
        } else if (state is EntryListFailure) {
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
