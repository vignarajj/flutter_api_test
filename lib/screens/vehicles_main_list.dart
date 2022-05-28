import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test/api/repos/vehicle_repository.dart';
import 'package:flutter_api_test/bloc/vehicles/vehicles_bloc.dart';
import 'package:flutter_api_test/bloc/vehicles/vehicles_events.dart';
import 'package:flutter_api_test/bloc/vehicles/vehicles_state.dart';
import 'package:flutter_api_test/common/screenConfig.dart';
import 'package:flutter_api_test/common/styles.dart';
import 'package:flutter_api_test/common/utils.dart';
import 'package:flutter_api_test/models/vehicles_list_model.dart';
import 'package:flutter_api_test/widgets/vehicle_item_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_api_test/common/routes.dart';

class VehiclesListScreen extends StatefulWidget {
  const VehiclesListScreen({Key? key}) : super(key: key);

  @override
  State<VehiclesListScreen> createState() => _VehiclesListScreenState();
}

class _VehiclesListScreenState extends State<VehiclesListScreen> {
  VehicleRepository repo = VehicleRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle List'),
        automaticallyImplyLeading: false,
      ),
      body: BlocProvider(
        create: (_) => VehiclesBloc(repo: repo)..add(GetVehiclesList()),
        child: BlocConditionView(),
      ),
    );
  }
}

class BlocConditionView extends StatefulWidget {
  const BlocConditionView({Key? key}) : super(key: key);

  @override
  State<BlocConditionView> createState() => _BlocConditionViewState();
}

class _BlocConditionViewState extends State<BlocConditionView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VehiclesBloc, VehicleState>(builder: (context, state) {
      switch (state.status) {
        case VehicleStateStatus.loading:
          return const Center(child: CircularProgressIndicator());
        case VehicleStateStatus.error:
          return const Center(child: Text('failed to fetch posts'));
        case VehicleStateStatus.loaded:
          if (state.data!.vehicleList.isEmpty) {
            return const Center(child: Text('No Vehicles found'));
          }
          return MajorView(model: state.data!);
        default:
          return const Center(
            child: Text("No Vehicles found"),
          );
      }
    });
  }
}

class MajorView extends StatefulWidget {
  final VehicleListModel model;

  const MajorView({Key? key, required this.model}) : super(key: key);

  @override
  State<MajorView> createState() => _MajorViewState();
}

class _MajorViewState extends State<MajorView> {
  VehicleModel? vehicleModel;

  VehicleListModel get _listModel => widget.model;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      children: [
        TopHalf(
          data: vehicleModel,
        ),
        BottomHalf(
            listModel: _listModel,
            callBack: (resultData) {
              setState(() {
                vehicleModel = resultData;
              });
            }),
      ],
    );
  }
}

class TopHalf extends StatefulWidget {
  final VehicleModel? data;

  const TopHalf({Key? key, required this.data}) : super(key: key);

  @override
  State<TopHalf> createState() => _TopHalfState();
}

class _TopHalfState extends State<TopHalf> {
  VehicleModel? get _data => widget.data;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight / 3,
      child: (_data == null)
          ? const Center(
              child: Text("Please select the Vehicle"),
            )
          : GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, vehiclePreviewScreen,
                    arguments: _data);
              },
              child: Hero(
                tag: previewImageTag,
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: _data!.image,
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          color: Colors.black54,
                          width: SizeConfig.screenWidth,
                          padding: const EdgeInsets.all(10),
                          child: Text(_data!.name, style: heading),
                        ))
                  ],
                ),
              ),
            ),
    );
  }
}

class BottomHalf extends StatefulWidget {
  final Function(VehicleModel) callBack;
  final VehicleListModel listModel;

  const BottomHalf({Key? key, required this.listModel, required this.callBack})
      : super(key: key);

  @override
  State<BottomHalf> createState() => _BottomHalfState();
}

class _BottomHalfState extends State<BottomHalf> {
  @override
  Widget build(BuildContext context) {
    final double itemHeight =
        (SizeConfig.screenHeight - kToolbarHeight - 24) / 3.4;
    final double itemWidth = SizeConfig.screenWidth / 2;
    return Expanded(
      flex: 3,
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (itemWidth / itemHeight),
          ),
          itemCount: widget.listModel.vehicleList.length,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            var data = widget.listModel.vehicleList[index];
            return GestureDetector(
              onTap: ()=>widget.callBack(data),
              child: VehicleItemView(
                data: data,
              ),
            );
          }),
    );
  }
}
