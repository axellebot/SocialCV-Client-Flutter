import 'package:cv/src/blocs/account_bloc.dart';
import 'package:cv/src/blocs/bloc_provider.dart';
import 'package:cv/src/models/api_models.dart';
import 'package:cv/src/models/user_model.dart';
import 'package:cv/src/widgets/bottom_sheet_menu_widget.dart';
import 'package:cv/src/widgets/initial_circle_avatar_widget.dart';
import 'package:flutter/material.dart';

class MenuIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return StreamBuilder<bool>(
      stream: _accountBloc.isAuthenticatedStream,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == true) return _buildConnectedMenuItem(context);
          if (snapshot.data == false)
            return _buildNotConnectedMenuItem(context);
        }
        return Container();
      },
    );
  }

  Widget _buildConnectedMenuItem(BuildContext context) {
    AccountBloc _accountBloc = BlocProvider.of<AccountBloc>(context);

    return StreamBuilder<ResponseModel<UserModel>>(
      stream: _accountBloc.fetchAccountDetailsStream,
      builder: (BuildContext context,
          AsyncSnapshot<ResponseModel<UserModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.data != null) {
            UserModel userModel = snapshot.data.data;
            return Padding(
                padding: EdgeInsets.only(top: 3.0, bottom: 3.0),
                child: IconButton(
                  onPressed: () => _openBottomSheet(context),
                  icon: InitialCircleAvatar(
                      text: userModel.username,
                      backgroundImage: NetworkImage(userModel.picture)),
                ));
          }
        }
        return Container();
      },
    );
  }

  Widget _buildNotConnectedMenuItem(BuildContext context) {
    return IconButton(
      onPressed: () => _openBottomSheet(context),
      icon: Icon(Icons.menu),
    );
  }

  void _openBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => BottomSheetMenu(),
    );
  }
}
