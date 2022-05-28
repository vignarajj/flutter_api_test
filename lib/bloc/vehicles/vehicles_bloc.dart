import 'package:flutter_api_test/api/repos/vehicle_repository.dart';
import 'package:flutter_api_test/bloc/vehicles/vehicles_events.dart';
import 'package:flutter_api_test/bloc/vehicles/vehicles_state.dart';
import 'package:flutter_api_test/models/vehicles_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VehiclesBloc extends Bloc<VehicleEvent, VehicleState> {
  final VehicleRepository _repo;
  VehiclesBloc({required VehicleRepository repo})
      : _repo = repo,
        super(const VehicleState()) {
    on<GetVehiclesList>(_getVehiclesList);
  }

  Future<void> _getVehiclesList(
      VehicleEvent event, Emitter<VehicleState> emit) async {
    emit(state.copyWith(status: VehicleStateStatus.loading));
    await emit.forEach<VehicleListModel>(_repo.getVehicleList().asStream(),
        onData: (vehicleList) => state.copyWith(
            status: VehicleStateStatus.loaded, data: vehicleList),
        onError: (_, __) => state.copyWith(status: VehicleStateStatus.error));
  }
}
