import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';
import 'package:social_cv_client_flutter/src/presentation/localizations/cv_localization.dart';
import 'package:social_cv_client_flutter/src/presentation/utils/logger.dart';
import 'package:social_cv_client_flutter/src/presentation/utils/navigation.dart';
import 'package:social_cv_client_flutter/src/presentation/widgets/error_widget.dart';

class AccountPage extends StatelessWidget {
  final String _tag = '$AccountPage';

  @override
  Widget build(BuildContext context) {
    Logger.log('$_tag:build');

    return SafeArea(
      left: false,
      right: false,
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        bloc: BlocProvider.of<AuthenticationBloc>(context),
        builder: (BuildContext context, AuthenticationState state) {
          if (state is AuthenticationUninitialized)
            return Container();
          else if (state is AuthenticationUnauthenticated)
            return _AccountPageDetailsNotConnected();
          else if (state is AuthenticationAuthenticated)
            return _AccountPageDetailsConnected();
          else if (state is AuthenticationLoading)
            return const Center(child: CircularProgressIndicator());
          else
            return Container();
        },
      ),
    );
  }
}

/// ----------------------------------------------------------------------------
///                      _AccountPageDetailsNotConnected
/// ----------------------------------------------------------------------------

class _AccountPageDetailsNotConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        child: Text(CVLocalizations.of(context)!.authLoginCTA),
        onPressed: () => navigateToLogin(context),
      ),
    );
  }
}

/// ----------------------------------------------------------------------------
///                      _AccountPageDetailsConnected
/// ----------------------------------------------------------------------------

class _AccountPageDetailsConnected extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IdentityBloc, IdentityState>(
      bloc: BlocProvider.of<IdentityBloc>(context),
      builder: (BuildContext context, IdentityState state) {
        if (state is IdentityUninitialized) {
        } else if (state is IdentityLoaded) {
          return ListView(
            children: <Widget>[
              ExpansionTile(
                leading: Icon(MdiIcons.accountBoxMultiple),
                title: Text(CVLocalizations.of(context)!.accountMyProfile),
                children: <Widget>[
//                  BlocProvider(
//                    bloc: ElementListBloc<ProfileEntity>(
//                      cvRepository: _repositories.cvRepository,
//                      preferencesRepository:
//                          _repositories.preferencesRepository,
//                    ),
//                    child: ProfileListWidget(
//                      fromUserEntity: snapshot.data,
//                      showOptions: false,
//                      shrinkWrap: true,
//                      physics: ClampingScrollPhysics(),
//                    ),
//                  ),
                ],
              ),
            ],
          );
        } else if (state is IdentityFailed) {
          return ErrorCard(error: state.error);
        }
        return ErrorCard(error: NotImplementedYetError());
      },
    );
  }
}
