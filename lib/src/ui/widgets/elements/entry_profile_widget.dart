import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/commons/api_values.dart';
import 'package:social_cv_client_flutter/src/ui/commons/dimensions.dart';
import 'package:social_cv_client_flutter/src/ui/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/entry_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/utils/navigation.dart';

class EntryProfileWidget extends EntryWidget {
  EntryProfileWidget(
      {Key key, String entryId, EntryViewModel entry, EntryBloc entryBloc})
      : super(key: key, entryId: entryId, entry: entry, entryBloc: entryBloc);

  @override
  State<StatefulWidget> createState() => _EntryProfileWidgetState();
}

class _EntryProfileWidgetState extends EntryWidgetState<EntryProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: this.entryBloc,
      builder: (BuildContext context, EntryState state) {
        if (state is EntryLoaded) {
          EntryViewModel entryViewModel = state.element;
          if (entryViewModel.type == kCVEntryTypeMap) {
            return _EntryWidgetMap(entry: entryViewModel);
          } else if (entryViewModel.type == kCVEntryTypeEvent) {
            return _EntryWidgetEvent(entry: entryViewModel);
          } else if (entryViewModel.type == kCVEntryTypeTag) {
            return _EntryWidgetTag(entryViewModel);
          } else {
            return ErrorContent(
                message: CVLocalizations.of(context).notSupported);
          }
        }
        return Container();
      },
    );
  }
}

class _EntryWidgetMap extends StatelessWidget {
  _EntryWidgetMap({
    @required this.entry,
  }) : assert(EntryViewModel != null);

  final EntryViewModel entry;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => navigateToEntry(context, entry: entry),
      child: Container(
        padding: EdgeInsets.all(AppDimensions.entryPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              '${entry.name ?? ''}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                '${entry.content ?? ''}',
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
    @required this.entry,
  }) : assert(EntryViewModel != null);

  final EntryViewModel entry;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppDimensions.entryCardElevation,
      child: Container(
        height: AppDimensions.entryEventHeight,
        width: AppDimensions.entryEventHWidth,
        padding: const EdgeInsets.all(AppDimensions.entryPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  '${entry.startDate}   ${entry.endDate}',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    color: Theme.of(context).accentColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Expanded(
                  child: Text(
                    entry.location ?? '',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                )
              ],
            ),
            Text(
              entry.name ?? '',
              textAlign: TextAlign.start,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Text(
                entry.content,
                textAlign: TextAlign.justify,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  child: Text(CVLocalizations.of(context).entryWidgetDetails),
                  onPressed: () => navigateToEntry(context, entry: entry),
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
  _EntryWidgetTag(this.entry);

  final EntryViewModel entry;

  @override
  Widget build(BuildContext context) {
    List<dynamic> tags = entry.content;
    List<Widget> _tagWidgets = [];
    tags.forEach((dynamic tag) {
      _tagWidgets.add(Chip(label: Text(tag as String)));
    });

    return Container(
      padding: EdgeInsets.all(AppDimensions.entryPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                entry.name.toUpperCase() ?? '',
                style: TextStyle(
                  color: Theme.of(context).accentColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FlatButton(
                child: Text(CVLocalizations.of(context).entryWidgetDetails),
                onPressed: () => navigateToEntry(context, entry: entry),
              )
            ],
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: AppDimensions.entryTagSpacing,
            runSpacing: 0.0,
            children: _tagWidgets,
          )
        ],
      ),
    );
  }
}
