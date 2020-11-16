import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final String _tag = '$RegisterBloc';

  final CVAuthService cvAuthService;

  RegisterBloc({@required this.cvAuthService})
      : assert(cvAuthService != null, 'No $CVAuthService given'),
        super();

  @override
  RegisterState get initialState => RegisterInitial();

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async* {
    print('$_tag:mapEventToState($event)');

    if (event is RegistrationEvent) {
      yield* _mapRegistrationEventToState(event);
    }
  }

  /// -----------------------------------------------------------------------
  ///                       All Event map to State
  /// -----------------------------------------------------------------------

  /// Map [RegistrationEvent] to [RegisterState]
  ///
  /// ```dart
  /// yield* _mapRegistrationEventToState(event);
  /// ```
  Stream<RegisterState> _mapRegistrationEventToState(
      RegistrationEvent event) async* {
    try {
      if (event is RegistrationEvent) {
        yield RegisterLoading();
        cvAuthService.register(
          fName: event.fName,
          lName: event.lName,
          email: event.email,
          password: event.password,
        );
        await Future.delayed(Duration(seconds: 2));
        yield RegisterInitial();
      }
    } catch (error) {
      yield RegisterFailure(error: error);
    }
  }
}
