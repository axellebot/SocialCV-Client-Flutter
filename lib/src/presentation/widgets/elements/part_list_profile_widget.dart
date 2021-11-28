import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/src/presentation/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/presentation/utils/utils.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/elements/part_list_widget.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/elements/part_profile_widget.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/sort_box_widget.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/sort_dialog_widget.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/sort_list_tile_widget.dart';

/// [SimplePartListProfile] is a dummy widget that use [partIds] or [parts] or
/// [partBlocs] to create a list of [PartProfileWidget]
class SimplePartListProfile extends StatelessWidget {
  final List<String> partIds;
  final List<PartEntity> parts;
  final List<PartBloc> partBlocs;

  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  const SimplePartListProfile({
    Key key,
    this.partIds,
    this.parts,
    this.partBlocs,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  })  : assert(partIds != null && parts == null && partBlocs == null),
        assert(partIds == null && parts != null && partBlocs == null),
        assert(partIds == null && parts == null && partBlocs != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    int itemCount;
    IndexedWidgetBuilder itemBuilder;

    if (partIds != null && partIds.isNotEmpty) {
      itemCount = partIds.length;
      itemBuilder = (BuildContext context, int index) =>
          PartProfileWidget(partId: partIds[index]);
    } else if (parts != null && parts.isNotEmpty) {
      itemCount = parts.length;
      itemBuilder = (BuildContext context, int index) =>
          PartProfileWidget(part: parts[index]);
    } else if (partBlocs != null && partBlocs.isNotEmpty) {
      itemCount = partBlocs.length;
      itemBuilder = (BuildContext context, int index) =>
          PartProfileWidget(partBloc: partBlocs[index]);
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

/// [ComplexPartListProfile] is a clever widget that use [parentProfileId] or
/// [ownerId] or [partListBloc] to display a list of [PartProfileWidget]
class ComplexPartListProfile extends PartListWidget {
  /// Search, filter and sort options
  final bool showOptions;

  /// List behaviors
  final Axis scrollDirection;
  final bool shrinkWrap;
  final ScrollPhysics physics;

  ComplexPartListProfile({
    Key key,
    String parentProfileId,
    String ownerId,
    PartListBloc partListBloc,

    /// Options
    this.showOptions = false,

    /// List behaviors
    this.scrollDirection = Axis.vertical,
    this.shrinkWrap = false,
    this.physics,
  }) : super(
          key: key,
          parentProfileId: parentProfileId,
          ownerId: ownerId,
          partListBloc: partListBloc,
        );

  @override
  State<StatefulWidget> createState() => _PartListProfileState();
}

class _PartListProfileState
    extends PartListWidgetState<ComplexPartListProfile> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartListBloc, PartListState>(
      bloc: widget.partListBloc,
      builder: (BuildContext context, PartListState state) {
        if (state is PartListLoading) {
          return LoadingList(
            count: state.count,
            scrollDirection: widget.scrollDirection,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
          );
        } else if (state is PartListLoaded) {
          final List<SortListItem> sortItems = <SortListItem>[
            SortListItem(field: 'name', title: 'Name', value: SortState.NoSort)
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
                            Text(CVLocalizations.of(context).partListSorting),
                        sortItems: sortItems,
                      );
                    },
                  );
                },
              ),
              DropdownButton(
                value: null,
                hint: Text(CVLocalizations.of(context).profileListItemPerPage),
                items: getDropDownMenuElementPerPage(),
                onChanged: (value) {},
              )
            ],
          );

          return ListView(
            scrollDirection: widget.scrollDirection,
            shrinkWrap: widget.shrinkWrap,
            physics: widget.physics,
            children: <Widget>[
              if (widget.showOptions) sortRow,
              for (var part in state.elements) PartProfileWidget(part: part),
              if (widget.showOptions)
                Center(
                  child: FlatButton(
                    onPressed: null,
                    child: Text(CVLocalizations.of(context).partListLoadMore),
                  ),
                ),
            ],
          );
        } else if (state is PartListFailure) {
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
