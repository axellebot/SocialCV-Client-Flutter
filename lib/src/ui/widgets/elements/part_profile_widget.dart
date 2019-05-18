import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/commons/api_values.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/group_list_profile_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/part_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

/// [PartProfileWidget] is an [PartWidget] for profile display purpose
class PartProfileWidget extends PartWidget {
  PartProfileWidget(
      {Key key, String partId, PartViewModel part, PartBloc partBloc})
      : super(key: key, partId: partId, part: part, partBloc: partBloc);

  @override
  State<StatefulWidget> createState() => _PartProfileWidgetState();
}

class _PartProfileWidgetState extends PartWidgetState<PartProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartEvent, PartState>(
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
  _PartWidgetFromModel({
    @required this.part,
  }) : assert(PartViewModel != null);

  final PartViewModel part;

  @override
  Widget build(BuildContext context) {
    if (part.type == kCVPartTypeListHorizontal) {
      return _PartWidgetFromModelHorizontal(
        partViewModel: part,
      );
    } else if (part.type == kCVPartTypeListVertical) {
      return _PartWidgetFromModelVertical(
        part: part,
      );
    } else {
      return ErrorRow(error: NotImplementedYetError());
    }
  }
}

class _PartWidgetFromModelHorizontal extends StatelessWidget {
  _PartWidgetFromModelHorizontal({
    @required this.partViewModel,
  }) : assert(PartViewModel != null);

  final PartViewModel partViewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              partViewModel.name.toUpperCase(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            FlatButton(
              child: Text(CVLocalizations.of(context).partWidgetDetails),
              onPressed: () => navigateToPart(context, partViewModel.id),
            ),
          ],
        ),
        Container(
          height: AppDimensions.horizontalGroupListHeight,
          child: SimpleGroupListProfile(
            groupIds: partViewModel.groupIds,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
          ),
        ),
      ],
    );
  }
}

class _PartWidgetFromModelVertical extends StatelessWidget {
  _PartWidgetFromModelVertical({
    @required this.part,
  }) : assert(part != null);

  final PartViewModel part;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              part.name.toUpperCase(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            FlatButton(
              child: Text(CVLocalizations.of(context).partWidgetDetails),
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
