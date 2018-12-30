import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/group_list_bloc.dart';
import 'package:cv/src/blocs/part_bloc.dart';
import 'package:cv/src/commons/api_values.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/localizations/cv_localization.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/utils/navigation.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/error_widget.dart';
import 'package:cv/src/widgets/group_list_widget.dart';
import 'package:cv/src/widgets/loading_widget.dart';
import 'package:flutter/material.dart';

class PartWidget extends StatelessWidget {
  PartWidget({
    Key key,
    this.fromPartModel,
    this.fromId,
  })  : assert(fromPartModel != null || fromId != null),
        super(key: key);

  final PartModel fromPartModel;
  final String fromId;

  @override
  Widget build(BuildContext context) {
    if (fromPartModel != null) {
      return _PartWidgetFromModel(partModel: fromPartModel);
    } else if (fromId != null) {
      PartBloc _partBloc = BlocProvider.of<PartBloc>(context);
      _partBloc.fetchPart(fromId);

      return StreamBuilder<PartModel>(
        stream: _partBloc.partStream,
        builder: (BuildContext context, AsyncSnapshot<PartModel> snapshot) {
          if (snapshot.hasError) {
            return ErrorContent(
              message: translateError(context, snapshot.error),
            );
          } else if (snapshot.hasData) {
            return _PartWidgetFromModel(partModel: snapshot.data);
          }
          return LoadingShadowContent(
            numberOfTitleLines: 1,
            numberOfContentLines: 2,
          );
        },
      );
    } else {
      return ErrorContent(
          message: CVLocalizations.of(context).notYetImplemented);
    }
  }
}

class _PartWidgetFromModel extends StatelessWidget {
  _PartWidgetFromModel({
    @required this.partModel,
  }) : assert(partModel != null);

  final PartModel partModel;

  @override
  Widget build(BuildContext context) {
    if (partModel.type == kCVPartTypeListHorizontal) {
      return _PartWidgetFromModelHorizontal(
        partModel: partModel,
      );
    } else if (partModel.type == kCVPartTypeListVertical) {
      return _PartWidgetFromModelVertical(
        partModel: partModel,
      );
    } else {
      return ErrorContent(message: CVLocalizations.of(context).notSupported);
    }
  }
}

class _PartWidgetFromModelHorizontal extends StatelessWidget {
  _PartWidgetFromModelHorizontal({
    @required this.partModel,
  }) : assert(partModel != null);

  final PartModel partModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              partModel.name.toUpperCase(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            FlatButton(
              child: Text(CVLocalizations.of(context).partWidgetDetails),
              onPressed: () => navigateToPart(context, partModel.id),
            ),
          ],
        ),
        Container(
          height: kCVHorizontalGroupListHeight,
          child: BlocProvider<GroupListBloc>(
            bloc: GroupListBloc(),
            child: GroupListWidget(
              fromPartModel: partModel,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
            ),
          ),
        ),
      ],
    );
  }
}

class _PartWidgetFromModelVertical extends StatelessWidget {
  _PartWidgetFromModelVertical({
    @required this.partModel,
  }) : assert(partModel != null);

  final PartModel partModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              partModel.name.toUpperCase(),
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold),
            ),
            FlatButton(
              child: Text(CVLocalizations.of(context).partWidgetDetails),
              onPressed: () => navigateToPart(context, partModel.id),
            ),
          ],
        ),
        BlocProvider<GroupListBloc>(
          bloc: GroupListBloc(),
          child: GroupListWidget(
            fromPartModel: partModel,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: ClampingScrollPhysics(),
          ),
        ),
      ],
    );
  }
}
