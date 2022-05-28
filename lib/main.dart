import 'package:flutter/material.dart';
import 'package:flutter_api_test/bloc/SimpleBlocObserver.dart';
import 'package:flutter_api_test/common/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

NavigatorState? navigatorState;

void main() {
  BlocOverrides.runZoned(
    () => runApp(const VehicleApiTestApp()),
    blocObserver: SimpleBlocObserver(),
  );
}

class VehicleApiTestApp extends StatefulWidget {
  const VehicleApiTestApp({Key? key}) : super(key: key);

  @override
  State<VehicleApiTestApp> createState() => _VehicleApiTestAppState();
}

class _VehicleApiTestAppState extends State<VehicleApiTestApp> {
  final GlobalKey<NavigatorState> navigatorStateKey =
      GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    navigatorState = navigatorStateKey.currentState;
    return MaterialApp(
      navigatorKey: navigatorStateKey,
      initialRoute: vehicleMainListScreen,
      onGenerateRoute: Routes().generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
