import 'package:equatable/equatable.dart';
import 'package:flutter_api_test/models/vehicles_list_model.dart';

enum VehicleStateStatus { initial, loading, loaded, error }

class VehicleState extends Equatable {
  const VehicleState({
    this.status = VehicleStateStatus.initial,
    this.data,
  });

  final VehicleStateStatus status;
  final VehicleListModel? data;

  @override
  List<Object?> get props => [status, data];

  VehicleState copyWith({
    VehicleStateStatus? status,
    VehicleListModel? data,
  }) {
    return VehicleState(status: status ?? this.status, data: data ?? this.data);
  }
}
