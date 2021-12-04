import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// Business Logic Component for Account
class IdentityBloc extends Bloc<IdentityEvent, IdentityState> {
  final String _tag = '$IdentityBloc';

  final IdentityRepository identityRepo;
  final AuthenticationBloc authBloc;
  late StreamSubscription authBlocSubscription;

  IdentityBloc({
    required this.identityRepo,
    required this.authBloc,
  }) : super(IdentityUninitialized()) {
    on<IdentityRefresh>(_onIdentityRefresh);

    authBlocSubscription = authBloc.stream.listen((state) {
      if (state is AuthenticationAuthenticated) {
        add(IdentityRefresh());
      }
    });
  }

  @override
  Future<void> close() async {
    await authBlocSubscription.cancel();
    await super.close();
  }

  /// -----------------------------------------------------------------------
  ///                       All Event map to State
  /// -----------------------------------------------------------------------

  /// Map [IdentityRefresh] to [IdentityState]
  FutureOr<void> _onIdentityRefresh(
    IdentityRefresh event,
    Emitter<IdentityState> emit,
  ) async {
    try {
      emit(IdentityLoading());
      final userModel = await identityRepo.getIdentity();
      emit(IdentityLoaded(user: userModel));
    } catch (error) {
      print('$_tag:_onIdentityRefresh -> ${error.runtimeType}');
      emit(IdentityFailed(error: error));
    }
  }
}
