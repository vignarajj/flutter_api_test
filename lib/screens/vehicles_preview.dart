import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test/common/styles.dart';
import 'package:flutter_api_test/common/utils.dart';
import 'package:flutter_api_test/models/vehicles_list_model.dart';

class VehiclesPreviewScreen extends StatefulWidget {
  final VehicleModel data;

  const VehiclesPreviewScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<VehiclesPreviewScreen> createState() => _VehiclesPreviewScreenState();
}

class _VehiclesPreviewScreenState extends State<VehiclesPreviewScreen> {
  VehicleModel get _data => widget.data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Preview"),
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: previewImageTag,
              child: CachedNetworkImage(
                imageUrl: _data.image,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 4.0, left: 4.0),
              child: Table(
                border: TableBorder.all(color: Colors.grey),
                children: [
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("ID", style: columnTitle),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "${_data.id}",
                        style: contentBlack,
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Vehicle Name", style: columnTitle),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        _data.name,
                        style: contentBlack,
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Name of Model", style: columnTitle),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        _data.model,
                        style: contentBlack,
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Age of Vehicle", style: columnTitle),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        "${_data.age}",
                        style: contentBlack,
                      ),
                    )
                  ]),
                  TableRow(children: [
                    const Padding(
                      padding: EdgeInsets.all(5.0),
                      child: Text("Description", style: columnTitle),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Text(
                        _data.description,
                        style: contentBlack,
                        textAlign: TextAlign.justify,
                      ),
                    )
                  ])
                ],
              ),
            ),
            const SizedBox(height: 40,),
          ],
        ),
      ),
    );
  }
}
