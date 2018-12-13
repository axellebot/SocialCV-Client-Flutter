import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/blocs/part_list_bloc.dart';
import 'package:cv/src/commons/utils.dart';
import 'package:cv/src/models/part_model.dart';
import 'package:cv/src/models/profile_model.dart';
import 'package:cv/src/widgets/card_error_widget.dart';
import 'package:cv/src/widgets/error_content_widget.dart';
import 'package:cv/src/widgets/loading_shadow_content_widget.dart';
import 'package:cv/src/widgets/part_widget.dart';
import 'package:flutter/widgets.dart';

class PartListWidget extends StatelessWidget {
  PartListWidget({
    this.fromProfileModel,
    this.fromSearch,
  });

  final ProfileModel fromProfileModel;
  final Object fromSearch;

  @override
  Widget build(BuildContext context) {
    if (fromProfileModel != null) {
      return _buildFromProfileModel(context);
    } else if (fromSearch != null) {
      return _buildFromSearch(context);
    }
    return ErrorContent("Not supported");
  }

  Widget _buildFromProfileModel(BuildContext context) {
    PartListBloc _partListBloc = BlocProvider.of<PartListBloc>(context);
    _partListBloc.fetchProfileParts(fromProfileModel.id);

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

  Widget _buildFromSearch(context) {
    return ErrorContent("Not Implemented Yet");
  }

  Widget _buildError(BuildContext context, Object error) {
    return ListView(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: <Widget>[
        CardError(message: translateError(context, error)),
      ],
    );
  }

  Widget _buildLoadingPart(BuildContext context) {
    int count = fromProfileModel.partIds.length;

    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: count,
      itemBuilder: (BuildContext context, int i) {
        return LoadingShadowContent(
          padding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
          numberOfTitleLines: 0,
          numberOfContentLines: 4,
        );
      },
    );
  }

  Widget _buildParts(context, List<PartModel> parts) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: parts.length,
      itemBuilder: (BuildContext context, int i) {
        return PartWidget(parts[i]);
      },
    );
  }
}
