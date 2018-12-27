import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/entry_list_bloc.dart';
import 'package:cv/src/blocs/group_bloc.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/utils/utils.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/entry_list_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({
    Key key,
    @required this.groupId,
  })  : assert(groupId != null),
        super(key: key);

  final String groupId;

  @override
  Widget build(BuildContext context) {
    GroupBloc _groupBloc = BlocProvider.of<GroupBloc>(context);
    _groupBloc.fetchGroup(groupId);

    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<GroupModel>(
          stream: _groupBloc.groupStream,
          builder: (BuildContext context, AsyncSnapshot<GroupModel> snapshot) {
            if (snapshot.hasError) {
              return Text("Error : ${snapshot.error.toString()}");
            } else if (snapshot.hasData) {
              GroupModel groupModel = snapshot.data;
              return Text(groupModel.name);
            }
            return LoadingShadowContent(
              numberOfTitleLines: 1,
              numberOfContentLines: 0,
            );
          },
        ),
      ),
      body: _GroupPageGroupBody(),
    );
  }
}

class _GroupPageGroupBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GroupBloc _profileGroupBloc = BlocProvider.of<GroupBloc>(context);

    return Stack(
      children: <Widget>[
        StreamBuilder<bool>(
          stream: _profileGroupBloc.isFetchingGroupStream,
          builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
            if (snapshot.data == true) {
              return LinearProgressIndicator();
            }
            return Container();
          },
        ),
        SafeArea(
          left: false,
          right: false,
          child: StreamBuilder<GroupModel>(
            stream: _profileGroupBloc.groupStream,
            builder:
                (BuildContext context, AsyncSnapshot<GroupModel> snapshot) {
              if (snapshot.hasError) {
                return CardError(
                  message: translateError(context, snapshot.error),
                );
              } else if (snapshot.hasData) {
                return BlocProvider<EntryListBloc>(
                  bloc: EntryListBloc(),
                  child: EntryListWidget(
                    fromGroupModel: snapshot.data,
                  ),
                );
              }
              return LoadingShadowContent(
                numberOfContentLines: 2,
                padding: EdgeInsets.all(10.0),
              );
            },
          ),
        ),
      ],
    );
  }
}
