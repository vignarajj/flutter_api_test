import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class VehicleEvent extends Equatable{
  const VehicleEvent();
  @override
  List<Object> get props => [];
}

class GetVehiclesList extends VehicleEvent{}