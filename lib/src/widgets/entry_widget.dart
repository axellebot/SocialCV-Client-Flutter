import 'package:cv/src/commons/paths.dart';
import 'package:cv/src/commons/values.dart';
import 'package:cv/src/localizations/localization.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:flutter/material.dart';

class EntryWidget extends StatelessWidget {
  EntryWidget(this.entryModel);

  final EntryModel entryModel;

  @override
  Widget build(BuildContext context) {
    if (entryModel.type == "map") {
      return _buildEntryMap(context, entryModel);
    } else if (entryModel.type == "event") {
      return _buildEntryEvent(context, entryModel);
    } else if (entryModel.type == "tag") {
      return _buildEntryTag(context, entryModel);
    } else {
      return _buildEntryDefault(entryModel);
    }
  }

  Widget _buildEntryDefault(EntryModel entryModel) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[Text("Unhandled entry type ${entryModel.type}")],
    );
  }

  Widget _buildEntryMap(BuildContext context, EntryModel entryModel) {
    return InkWell(
      onTap: () => Navigator.of(context)
          .pushNamed(kPathEntries + '/${entryModel.id ?? ""}'),
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

  Widget _buildEntryEvent(BuildContext context, EntryModel entryModel) {
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
                    onPressed: () => Navigator.of(context)
                        .pushNamed(kPathEntries + '/${entryModel.id ?? ""}'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEntryTag(BuildContext context, EntryModel entryModel) {
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
                onPressed: () => Navigator.of(context)
                    .pushNamed(kPathEntries + '/${entryModel.id ?? ""}'),
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
