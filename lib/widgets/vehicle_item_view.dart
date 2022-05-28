import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_test/common/screenConfig.dart';
import 'package:flutter_api_test/common/styles.dart';
import 'package:flutter_api_test/common/utils.dart';
import 'package:flutter_api_test/models/vehicles_list_model.dart';

class VehicleItemView extends StatelessWidget {
  const VehicleItemView({
    Key? key,
    required this.data,
  }) : super(key: key);

  final VehicleModel data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(1.0),
      child: Stack(
        fit: StackFit.loose,
        children: [
          GestureDetector(
            onTap: () => Navigator.push(context, _imagePreview(data.image)),
            child: Hero(
              tag: itemImagePreview,
              child: CachedNetworkImage(
                imageUrl: data.image,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => const Icon(Icons.error),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              color: Colors.black.withOpacity(0.8),
              width: SizeConfig.screenWidth / 2,
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data.name,
                    style: subHeading,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    data.model,
                    style: contentWhite,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Route _imagePreview(imageUrl) {
  return PageRouteBuilder(
    opaque: true,
    barrierDismissible: false,
    pageBuilder: (BuildContext context, _, __) {
      return Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.cancel_sharp)),
              ),
              Expanded(
                child: InteractiveViewer(
                  scaleEnabled: true,
                  panEnabled: true,
                  child: Hero(
                    tag: itemImagePreview,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: imageUrl,
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
