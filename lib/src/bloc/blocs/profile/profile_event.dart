import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

/// [ProfileEvent] that must be dispatch to [ProfileBloc]

abstract class ProfileEvent extends Equatable {
  ProfileEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class ProfileInitialized extends ProfileEvent
    with ElementInitialize<ProfileEntity> {
  ProfileInitialized({String profileId, ProfileEntity profile})
      : assert(
          profileId != null && profile == null,
          '$ProfileInitialized must be created with an $ProfileEntity or its ID',
        ),
        assert(
          profileId == null && profile != null,
          '$ProfileInitialized must be created with an $ProfileEntity or its ID',
        ),
        super([profileId, profile]) {
    this.elementId = profileId;
    this.element = profile;
  }

  @override
  String toString() => '$runtimeType{ '
      'id: $elementId, '
      'element: $element'
      ' }';
}

class ProfileRefresh extends ProfileEvent with ElementRefresh<ProfileEntity> {}
