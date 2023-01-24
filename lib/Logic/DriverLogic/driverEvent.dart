import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sure_move/Presentation/utils/enums.dart';

abstract class DriverEvent extends Equatable {
  const DriverEvent();

  @override
  List<Object> get props => [];
}

// this state ensures that the previous state is fetched when application starts
class DriversInit extends DriverEvent {}


class DriverUpdateStatusRequested extends DriverEvent {
  const DriverUpdateStatusRequested(this.driverId, this.type);
  final String driverId;
  final String type;

  @override
  List<Object> get props => [driverId, type];
}


