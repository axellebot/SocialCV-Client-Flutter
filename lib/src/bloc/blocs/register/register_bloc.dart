import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final String _tag = '$RegisterBloc';

  final CVAuthService cvAuthService;

  RegisterBloc({
    required this.cvAuthService,
  }) : super(RegisterInitial()) {
    on<RegistrationEvent>(_mapRegistrationEventToState);
  }

  /// -----------------------------------------------------------------------
  ///                       All Event map to State
  /// -----------------------------------------------------------------------

  /// Map [RegistrationEvent] to [RegisterState]
  FutureOr<void> _mapRegistrationEventToState(
    RegistrationEvent event,
    Emitter<RegisterState> emit,
  ) async {
    try {
      if (event is RegistrationEvent) {
        emit(RegisterLoading());
        cvAuthService.register(
          fName: event.fName,
          lName: event.lName,
          email: event.email,
          password: event.password,
        );
        await Future.delayed(const Duration(seconds: 2));
        emit(RegisterInitial());
      }
    } catch (error) {
      emit(RegisterFailure(error: error));
    }
  }
}
