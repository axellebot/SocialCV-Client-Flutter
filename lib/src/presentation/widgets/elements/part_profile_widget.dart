import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

/// [PartProfileWidget] is an [PartWidget] for profile display purpose
class PartProfileWidget extends PartWidget {
  const PartProfileWidget({
    Key? key,
    String? partId,
    PartEntity? part,
    PartBloc? partBloc,
  }) : super(
          key: key,
          partId: partId,
          part: part,
          partBloc: partBloc,
        );

  @override
  State<StatefulWidget> createState() => _PartProfileWidgetState();
}

class _PartProfileWidgetState extends PartWidgetState<PartProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartBloc, PartState>(
      bloc: partBloc,
      builder: (BuildContext context, PartState state) {
        if (state is PartLoading) {
          return LoadingShadowContent(
            numberOfTitleLines: 1,
            numberOfContentLines: 2,
          );
        } else if (state is PartLoaded) {
          return _PartWidgetFromModel(part: state.element);
        } else if (state is PartFailure) {
          return ErrorRow(error: state.error);
        }
        return ErrorRow(error: NotImplementedYetError());
      },
    );
  }
}

class _PartWidgetFromModel extends StatelessWidget {
  const _PartWidgetFromModel({
    required this.part,
  });

  final PartEntity? part;

  @override
  Widget build(BuildContext context) {
    if (part!.type == kCVPartTypeListHorizontal) {
      return _PartWidgetFromModelHorizontal(
        partEntity: part,
      );
    } else if (part!.type == kCVPartTypeListVertical) {
      return _PartWidgetFromModelVertical(
        part: part!,
      );
    } else {
      return ErrorRow(error: NotImplementedYetError());
    }
  }
}

class _PartWidgetFromModelHorizontal extends StatelessWidget {
  const _PartWidgetFromModelHorizontal({
    required this.partEntity,
  });

  final PartEntity? partEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              partEntity!.name!.toUpperCase(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
              child: Text(CVLocalizations.of(context)!.partWidgetDetails),
              onPressed: () => navigateToPart(context, partEntity!.id),
            ),
          ],
        ),
        Container(
          height: AppStyles.groupHorizontalListHeight,
          child: SimpleGroupListProfile(
            groupIds: partEntity!.groupIds,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }
}

class _PartWidgetFromModelVertical extends StatelessWidget {
  const _PartWidgetFromModelVertical({
    required this.part,
  });

  final PartEntity part;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              part.name!.toUpperCase(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
              child: Text(CVLocalizations.of(context)!.partWidgetDetails),
              onPressed: () => navigateToPart(context, part.id),
            ),
          ],
        ),
        SimpleGroupListProfile(
          groupIds: part.groupIds,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
        ),
      ],
    );
  }
}
