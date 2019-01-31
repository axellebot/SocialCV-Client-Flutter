import 'package:flutter/material.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/commons/api_values.dart';
import 'package:social_cv_client_flutter/src/commons/values.dart';
import 'package:social_cv_client_flutter/src/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';
import 'package:social_cv_client_flutter/src/widgets/error_widget.dart';

class EntryWidget extends StatelessWidget {
  const EntryWidget({
    Key key,
    @required this.entryModel,
  })  : assert(entryModel != null),
        super(key: key);

  final EntryModel entryModel;

  @override
  Widget build(BuildContext context) {
    if (entryModel.type == kCVEntryTypeMap) {
      return _EntryWidgetMap(entryModel: entryModel);
    } else if (entryModel.type == kCVEntryTypeEvent) {
      return _EntryWidgetEvent(entryModel: entryModel);
    } else if (entryModel.type == kCVEntryTypeTag) {
      return _EntryWidgetTag(entryModel);
    } else {
      return ErrorContent(message: CVLocalizations.of(context).notSupported);
    }
  }
}

class _EntryWidgetMap extends StatelessWidget {
  _EntryWidgetMap({
    @required this.entryModel,
  }) : assert(entryModel != null);

  final EntryModel entryModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToEntry(context, entryModel.id),
      child: Container(
        padding: EdgeInsets.all(kCVEntryPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              "${entryModel.name ?? ""}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                "${entryModel.content ?? ""}",
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _EntryWidgetEvent extends StatelessWidget {
  _EntryWidgetEvent({
    @required this.entryModel,
  }) : assert(entryModel != null);

  final EntryModel entryModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kCVEntryCardElevation,
      child: Container(
        height: kCVEntryEventHeight,
        width: kCVEntryEventHWidth,
        padding: const EdgeInsets.all(kCVEntryPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "${entryModel.startDate}   ${entryModel.endDate}",
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    entryModel.location ?? "",
                    textAlign: TextAlign.end,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
            Text(
              entryModel.name ?? "",
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                entryModel.content,
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text(CVLocalizations.of(context).entryWidgetDetails),
                  onPressed: () => navigateToEntry(context, entryModel.id),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class _EntryWidgetTag extends StatelessWidget {
  _EntryWidgetTag(this.entryModel);

  final EntryModel entryModel;

  @override
  Widget build(BuildContext context) {
    List<dynamic> tags = entryModel.content;
    List<Widget> _tagWidgets = [];
    tags.forEach((dynamic tag) {
      _tagWidgets.add(Chip(label: Text(tag as String)));
    });

    return Container(
      padding: EdgeInsets.all(kCVEntryPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                entryModel.name.toUpperCase() ?? "",
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                child: Text(CVLocalizations.of(context).entryWidgetDetails),
                onPressed: () => navigateToEntry(context, entryModel.id),
              )
            ],
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: kCVEntryTagSpacing,
            runSpacing: 0.0,
            children: _tagWidgets,
          )
        ],
      ),
    );
  }
}
