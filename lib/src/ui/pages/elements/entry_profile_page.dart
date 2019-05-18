import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/errors.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/entry_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/error_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';

class EntryPage extends EntryWidget {
  EntryPage(
      {Key key, String entryId, EntryViewModel entry, EntryBloc entryBloc})
      : super(key: key, entryId: entryId, entry: entry, entryBloc: entryBloc);

  @override
  State<StatefulWidget> createState() => _EntryPageState();
}

class _EntryPageState extends EntryWidgetState<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryEvent, EntryState>(
      bloc: entryBloc,
      builder: (BuildContext context, EntryState state) {
        if (state is EntryLoading) {
          return Scaffold(
            appBar: AppBar(
              title: LoadingShadowContent(
                numberOfTitleLines: 1,
                numberOfContentLines: 0,
              ),
            ),
            body: SingleChildScrollView(
              child: LoadingShadowContent(
                numberOfContentLines: 2,
                padding: EdgeInsets.all(10.0),
              ),
            ),
          );
        } else if (state is EntryLoaded) {
          EntryViewModel model = state.element;

          return Scaffold(
            appBar: AppBar(title: Text(model.name)),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: Text('name'),
                  subtitle: Text(model.name),
                ),
                ListTile(
                  title: Text('type'),
                  subtitle: Text(model.type),
                ),
                ListTile(
                  title: Text('content'),
                  subtitle: Text(model.content),
                ),
              ],
            ),
          );
        }
        return ErrorCard(error: NotImplementedYetError());
      },
    );
  }
}
