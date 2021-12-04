import 'package:equatable/equatable.dart';
import 'package:social_cv_client_flutter/bloc.dart';
import 'package:social_cv_client_flutter/domain.dart';

abstract class PartEvent extends Equatable {
  const PartEvent() : super();

  @override
  List<Object?> get props => [];

  @override
  String toString() => '$runtimeType{}';
}

class PartInitialize extends PartEvent with ElementInitialize<PartEntity> {
  PartInitialize({
    String? partId,
    PartEntity? part,
  })  : assert(
          partId != null && part == null,
          '$PartInitialize must be created with a $PartEntity or its ID',
        ),
        assert(
          partId == null && part != null,
          '$PartInitialize must be created with a $PartEntity or its ID',
        ),
        super() {
    elementId = partId;
    element = part;
  }

  @override
  List<Object?> get props => super.props..addAll([elementId, element]);

  @override
  String toString() => '$runtimeType{ '
      'id: $elementId, '
      'part: $element'
      ' }';
}

class PartRefresh extends PartEvent with ElementRefresh<PartEntity> {}
