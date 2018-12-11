import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/part_list_bloc.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:cv/src/widgets/part_widget.dart';
import 'package:flutter/widgets.dart';

class ProfilePartListWidget extends StatelessWidget {
  ProfilePartListWidget(this.profileModel);
  final ProfileModel profileModel;

  @override
  Widget build(BuildContext context) {
    PartListBloc _partListBloc = BlocProvider.of<PartListBloc>(context);
    _partListBloc.fetchProfileParts(profileModel.id);

    return StreamBuilder<List<PartModel>>(
      stream: _partListBloc.partsStream,
      builder: (BuildContext context, AsyncSnapshot<List<PartModel>> snapshot) {
        if (snapshot.hasError) {
          return _buildError(context, snapshot.error);
        } else if (snapshot.hasData) {
          return _buildParts(context, snapshot.data);
        }
        return _buildLoadingPart(context);
      },
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return CardError(message: translateError(context, error));
  }

  Widget _buildParts(context, List<PartModel> parts) {
    List<Widget> _widgets = [];
    parts.forEach((PartModel partModel) {
      _widgets.add(PartWidget(partModel));
    });
    return Column(children: _widgets);
  }

  Widget _buildLoadingPart(BuildContext context) {
    List<Widget> _widgets = [];
    int count = profileModel.partIds.length;

    for (int i = 0; i < count; i++) {
      _widgets.add(LoadingShadowContent(
        padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        numberOfTitleLines: 0,
        numberOfContentLines: 4,
      ));
    }

    return Column(children: _widgets);
  }
}
