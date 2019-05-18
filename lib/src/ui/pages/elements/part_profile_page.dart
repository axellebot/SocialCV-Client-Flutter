import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_cv_client_dart_common/blocs.dart';
import 'package:social_cv_client_dart_common/models.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/elements/part_widget.dart';
import 'package:social_cv_client_flutter/src/ui/widgets/loading_widget.dart';

class PartProfilePage extends PartWidget {
  PartProfilePage(
      {Key key, String partId, PartViewModel part, PartBloc partBloc})
      : super(key: key, partId: partId, part: part, partBloc: partBloc);

  @override
  State<StatefulWidget> createState() => _PartProfilePageState();
}

class _PartProfilePageState extends PartWidgetState<PartProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PartEvent, PartState>(
      bloc: partBloc,
      builder: (BuildContext context, PartState state) {
        if (state is PartLoading) {
          return Scaffold(
            appBar: AppBar(
              title: LoadingShadowContent(
                numberOfTitleLines: 1,
              ),
            ),
            body: SingleChildScrollView(
              child: SingleChildScrollView(
                child: LoadingShadowContent(
                  numberOfContentLines: 2,
                  padding: EdgeInsets.all(10.0),
                ),
              ),
            ),
          );
        } else if (state is PartLoaded) {
          PartViewModel model = state.element;

          return Scaffold(
            appBar: AppBar(title: Text(model.name)),
            body: ListView.builder(
              itemBuilder: (BuildContext context, int index) {},
            ),
          );
        }
      },
    );
  }
}
