import 'package:flutter_api_test/api/services/vehicle_services.dart';
import 'package:flutter_api_test/models/vehicles_list_model.dart';

class VehicleRepository {
  final vehicleService = VehicleServices();

  Future<VehicleListModel> getVehicleList() {
    return vehicleService.getVehiclesList();
  }
}
