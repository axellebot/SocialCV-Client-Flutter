import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/commons/api_values.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/group_list_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/part_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';
import 'package:social_cv_client_flutter/src/utils/utils.dart';

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
        }
        if (state is PartLoaded) {
          return _PartWidgetFromModel(partViewModel: state.element);
        } else if (state is PartFailure) {
          return ErrorContent(
            message: translateError(context, state.error),
          );
        }
        return ErrorContent(
            message: CVLocalizations.of(context).notYetImplemented);
      },
    );
  }
}

class _PartWidgetFromModel extends StatelessWidget {
  _PartWidgetFromModel({
    @required this.partViewModel,
  }) : assert(PartViewModel != null);

  final PartViewModel partViewModel;

  @override
  Widget build(BuildContext context) {
    if (partViewModel.type == kCVPartTypeListHorizontal) {
      return _PartWidgetFromModelHorizontal(
        partViewModel: partViewModel,
      );
    } else if (partViewModel.type == kCVPartTypeListVertical) {
      return _PartWidgetFromModelVertical(
        partViewModel: partViewModel,
      );
    } else {
      return ErrorContent(message: CVLocalizations.of(context).notSupported);
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
          child: GroupListWidget(
            fromPartViewModel: partViewModel,
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
        GroupListWidget(
          fromPartViewModel: partViewModel,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
        ),
      ],
    );
  }
}
