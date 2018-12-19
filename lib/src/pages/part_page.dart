import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/group_bloc.dart';
import 'package:cv/src/blocs/group_list_bloc.dart';
import 'package:cv/src/blocs/part_bloc.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/widgets/group_list_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:flutter/material.dart';

class PartPage extends StatelessWidget {
  PartPage(this.profilePartId);

  final String profilePartId;

  @override
  Widget build(BuildContext context) {
    PartBloc _profilePartBloc = BlocProvider.of<PartBloc>(context);
    _profilePartBloc.fetchProfilePart(profilePartId);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    PartBloc _partBloc = BlocProvider.of<PartBloc>(context);

    return AppBar(
      title: StreamBuilder<PartModel>(
        stream: _partBloc.partStream,
        builder: (BuildContext context, AsyncSnapshot<PartModel> snapshot) {
          if (snapshot.hasError) {
            return Text("Error : ${snapshot.error.toString()}");
          } else if (snapshot.hasData) {
            PartModel partModel = snapshot.data;
            return Text(partModel.name);
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
    PartBloc _partBloc = BlocProvider.of<PartBloc>(context);

    return SingleChildScrollView(
      child: SafeArea(
        left: false,
        right: false,
        child: StreamBuilder<PartModel>(
          stream: _partBloc.partStream,
          builder: (BuildContext context, AsyncSnapshot<PartModel> snapshot) {
            if (snapshot.hasError) {
              return Card(child: Text("Error : ${snapshot.error.toString()}"));
            } else if (snapshot.hasData) {
              return _buildPartWidget(snapshot.data);
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

  Widget _buildPartWidget(PartModel partModel) {
    return BlocProvider<GroupListBloc>(
      bloc: GroupListBloc(),
      child: GroupListWidget(
        fromPartModel: partModel,
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
      ),
    );
  }
}
