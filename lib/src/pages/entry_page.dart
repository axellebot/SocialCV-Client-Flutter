import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_bloc.dart';
import 'package:cv/src/models/entry_model.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:flutter/material.dart';

class EntryPage extends StatelessWidget {
  EntryPage(this.entryId);

  final String entryId;

  @override
  Widget build(BuildContext context) {
    EntryBloc _entryBloc = BlocProvider.of<EntryBloc>(context);
    _entryBloc.fetchEntry(entryId);

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<EntryModel>(
          stream: _entryBloc.entryStream,
          builder: (BuildContext context, AsyncSnapshot<EntryModel> snapshot) {
            if (snapshot.hasError) {
              return Text("Error : ${snapshot.error.toString()}");
            } else if (snapshot.hasData) {
              EntryModel entryModel = snapshot.data;
              return Text(entryModel.name);
            }
            return LoadingShadowContent(
              numberOfTitleLines: 1,
              numberOfContentLines: 0,
            );
          },
        ),
      ),
      body: _EntryPageEntryBody(),
    );
  }
}

class _EntryPageEntryBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    EntryBloc _entryBloc = BlocProvider.of<EntryBloc>(context);

    return Stack(
      children: <Widget>[
        StreamBuilder<bool>(
          stream: _entryBloc.isFetchingEntryStream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return LinearProgressIndicator();
            }
            return Container();
          },
        ),
        SingleChildScrollView(
          child: SafeArea(
            left: false,
            right: false,
            child: StreamBuilder<EntryModel>(
              stream: _entryBloc.entryStream,
              builder:
                  (BuildContext context, AsyncSnapshot<EntryModel> snapshot) {
                if (snapshot.hasError) {
                  return CardError(
                      message: translateError(context, snapshot.error));
                } else if (snapshot.hasData) {
                  return Text(snapshot.data.toString());
                }
                return LoadingShadowContent(
                  numberOfContentLines: 2,
                  padding: EdgeInsets.all(10.0),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
