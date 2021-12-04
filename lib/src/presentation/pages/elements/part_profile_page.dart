import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/elements/part_widget.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/loading_widget.dart';

class PartProfilePage extends PartWidget {
  const PartProfilePage(
      {Key? key, String? partId, PartEntity? part, PartBloc? partBloc})
      : super(key: key, partId: partId, part: part, partBloc: partBloc);

  @override
  State<StatefulWidget> createState() => _PartProfilePageState();
}

class _PartProfilePageState extends PartWidgetState<PartProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartBloc, PartState>(
      bloc: partBloc,
      builder: (BuildContext context, PartState state) {
        if (state is PartLoading) {
          return Scaffold(
            appBar: AppBar(
              title: const LoadingShadowContent(
                numberOfTitleLines: 1,
              ),
            ),
            body: SingleChildScrollView(
              child: SingleChildScrollView(
                child: const LoadingShadowContent(
                  numberOfContentLines: 2,
                  padding: EdgeInsets.all(10.0),
                ),
              ),
            ),
          );
        } else if (state is PartLoaded) {
          final PartEntity model = state.element;

          return Scaffold(
            appBar: AppBar(title: Text(model.name!)),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return Container();
              },
            ),
          );
        }
        return Container();
      },
    );
  }
}
