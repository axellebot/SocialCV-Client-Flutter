import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class PartEvent extends Equatable {
  PartEvent([List props = const []]) : super(props);

  @override
  String toString() => '$runtimeType{}';
}

class PartInitialized extends PartEvent with ElementInitialized<PartEntity> {
  PartInitialized({String partId, PartEntity part})
      : assert(
          partId != null && part == null,
          '$PartInitialized must be created with a $PartEntity or its ID',
        ),
        assert(
          partId == null && part != null,
          '$PartInitialized must be created with a $PartEntity or its ID',
        ),
        super([partId, part]) {
    elementId = partId;
    element = part;
  }

  @override
  String toString() => '$runtimeType{ '
      'id: $elementId, '
      'part: $element'
      ' }';
}

class PartRefresh extends PartEvent with ElementRefresh<PartEntity> {}
