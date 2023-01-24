import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({Key? key,required this.latitude,required this.longitude}) : super(key: key);
  final dynamic latitude;
  final dynamic longitude;
  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {

  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  Set<Marker> _createMarker() {
    return {
      Marker(
          markerId: MarkerId("marker_1"),
          position: LatLng(widget.latitude,widget.longitude)),

    };
  }
  @override
  Widget build(BuildContext context) {
    CameraPosition googlePlex = CameraPosition(
      target: LatLng(widget.latitude, widget.longitude),
      zoom: 14.4746,

    );
    return GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: googlePlex,
        markers: _createMarker(),
        trafficEnabled: true,
        //liteModeEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);

        });

  }
}
