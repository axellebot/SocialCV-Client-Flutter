import 'package:cv/src/commons/values.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/utils/navigation.dart';
import 'package:flutter/material.dart';

class EntryWidget extends StatelessWidget {
  const EntryWidget({
    Key key,
    @required this.entryModel,
  })  : assert(entryModel != null),
        super(key: key);

  final EntryModel entryModel;

  @override
  Widget build(BuildContext context) {
    if (entryModel.type == "map") {
      return _EntryWidgetMap(entryModel);
    } else if (entryModel.type == "event") {
      return _EntryWidgetEvent(entryModel);
    } else if (entryModel.type == "tag") {
      return _EntryWidgetTag(entryModel);
    } else {
      return _EntryWidgetDefault(entryModel);
    }
  }
}

class _EntryWidgetDefault extends StatelessWidget {
  _EntryWidgetDefault(this.entryModel);

  final EntryModel entryModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[Text("Unhandled entry type ${entryModel.type}")],
    );
  }
}

class _EntryWidgetMap extends StatelessWidget {
  _EntryWidgetMap(this.entryModel);

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
  _EntryWidgetEvent(this.entryModel);

  final EntryModel entryModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: kCVEntryCardElevation,
      child: InkWell(
        onTap: () {},
        child: Container(
          height: 75.0,
          width: 300.0,
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
                    child: Text(Localization.of(context).more),
                    onPressed: () => navigateToEntry(context, entryModel.id),
                  )
                ],
              )
            ],
          ),
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
                child: Text(Localization.of(context).more),
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
