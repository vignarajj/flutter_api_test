import 'dart:convert';

import 'package:flutter_api_test/common/utils.dart';
import 'package:flutter_api_test/models/vehicles_list_model.dart';
import 'package:http/http.dart' as http;

class VehicleServices {
  Future<VehicleListModel> getVehiclesList() async {
    try {
      var response = await http.get(Uri.parse(vehicleApi));
      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = VehicleListModel.fromJson(json.decode(response.body));
        return data;
      } else {
        return throw Exception("Unable to connect server");
      }
    } catch (e) {
      return throw Exception(e);
    }
  }
}
