import 'package:flutter/material.dart';
import 'package:flutter_api_test/models/vehicles_list_model.dart';
import 'package:flutter_api_test/screens/vehicles_main_list.dart';
import 'package:flutter_api_test/screens/vehicles_preview.dart';

class Routes {
  Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case vehicleMainListScreen:
        return MaterialPageRoute(builder: (_) => const VehiclesListScreen());
      case vehiclePreviewScreen:
        return MaterialPageRoute(
            builder: (_) => VehiclesPreviewScreen(
                  data: settings.arguments as VehicleModel,
                ));
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}

const vehicleMainListScreen = "/vehiclesScreens";
const vehiclePreviewScreen = "/vehiclePreview";
