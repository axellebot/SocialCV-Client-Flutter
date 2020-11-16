import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Account
class IdentityBloc extends Bloc<IdentityEvent, IdentityState> {
  final String _tag = '$IdentityBloc';

  final IdentityRepository identityRepo;
  final AuthenticationBloc authBloc;
  StreamSubscription authBlocSubscription;

  IdentityBloc({
    @required this.identityRepo,
    @required this.authBloc,
  })  : assert(identityRepo != null, 'No $IdentityRepository given'),
        super() {
    authBlocSubscription = authBloc.state.listen((state) {
      if (state is AuthenticationAuthenticated) {
        dispatch(IdentityRefresh());
      }
    });
  }

  @override
  void dispose() {
    authBlocSubscription.cancel();
    super.dispose();
  }

  @override
  IdentityState get initialState => IdentityUninitialized();

  @override
  Stream<IdentityState> mapEventToState(IdentityEvent event) async* {
    print('$_tag:mapEventToState($event)');

    if (event is IdentityRefresh) {
      yield* _mapAccountRefreshToState(event);
    }
  }

  /// -----------------------------------------------------------------------
  ///                       All Event map to State
  /// -----------------------------------------------------------------------

  /// Map [IdentityRefresh] to [IdentityState]
  ///
  /// ```dart
  /// yield* _mapAccountRefreshToState(event);
  /// ```
  Stream<IdentityState> _mapAccountRefreshToState(
      IdentityRefresh event) async* {
    try {
      yield IdentityLoading();
      final userModel = await identityRepo.getIdentity();
      yield IdentityLoaded(user: userModel);
    } catch (error) {
      print('$_tag:_mapAccountRefreshToState -> ${error.runtimeType}');
      yield IdentityFailed(error: error);
    }
  }
}
