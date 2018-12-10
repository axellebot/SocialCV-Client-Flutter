import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/group_bloc.dart';
import 'package:cv/src/models/group_model.dart';
import 'package:cv/src/widgets/group_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:flutter/material.dart';

class GroupPage extends StatelessWidget {
  GroupPage(this.profileGroupId);

  final String profileGroupId;

  @override
  Widget build(BuildContext context) {
    GroupBloc _profileGroupBloc = BlocProvider.of<GroupBloc>(context);
    _profileGroupBloc.fetchGroup(profileGroupId);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    GroupBloc _profileGroupBloc = BlocProvider.of<GroupBloc>(context);

    return AppBar(
      title: StreamBuilder<GroupModel>(
        stream: _profileGroupBloc.groupStream,
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
    );
  }

  Widget _buildProgressBar(BuildContext context) {
    GroupBloc _profileGroupBloc = BlocProvider.of<GroupBloc>(context);

    return StreamBuilder<bool>(
      stream: _profileGroupBloc.isFetchingGroupStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.data == true) {
          return LinearProgressIndicator();
        }
        return Container();
      },
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: <Widget>[
        _buildProgressBar(context),
        _buildMain(context),
      ],
    );
  }

  Widget _buildMain(context) {
    GroupBloc _profileGroupBloc = BlocProvider.of<GroupBloc>(context);

    return SingleChildScrollView(
      child: SafeArea(
        left: false,
        right: false,
        child: StreamBuilder<GroupModel>(
          stream: _profileGroupBloc.groupStream,
          builder: (BuildContext context, AsyncSnapshot<GroupModel> snapshot) {
            if (snapshot.hasError) {
              return Card(child: Text("Error : ${snapshot.error.toString()}"));
            } else if (snapshot.hasData) {
              return _buildGroupWidget(snapshot.data);
            }
            return LoadingShadowContent(
              numberOfContentLines: 2,
              padding: EdgeInsets.all(10.0),
            );
          },
        ),
      ),
    );
  }

  Widget _buildGroupWidget(GroupModel groupModel) {
    return GroupWidget(groupModel);
  }
}
