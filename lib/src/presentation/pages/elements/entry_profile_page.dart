import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/presentation.dart';

class EntryPage extends EntryWidget {
  EntryPage({Key key, String entryId, EntryEntity entry, EntryBloc entryBloc})
      : super(key: key, entryId: entryId, entry: entry, entryBloc: entryBloc);

  @override
  State<StatefulWidget> createState() => _EntryPageState();
}

class _EntryPageState extends EntryWidgetState<EntryPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EntryBloc, EntryState>(
      bloc: entryBloc,
      builder: (BuildContext context, EntryState state) {
        if (state is EntryLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const LoadingShadowContent(
                numberOfTitleLines: 1,
                numberOfContentLines: 0,
              ),
            ),
            body: SingleChildScrollView(
              child: const LoadingShadowContent(
                numberOfContentLines: 2,
                padding: const EdgeInsets.all(10.0),
              ),
            ),
          );
        } else if (state is EntryLoaded) {
          final EntryEntity model = state.element;

          return Scaffold(
            appBar: AppBar(title: Text(model.name)),
            body: ListView(
              children: <Widget>[
                ListTile(
                  title: const Text('name'),
                  subtitle: Text(model.name),
                ),
                ListTile(
                  title: const Text('type'),
                  subtitle: Text(model.type),
                ),
                ListTile(
                  title: const Text('content'),
                  subtitle: Text(model.content.toString()),
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
