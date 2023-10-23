import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng source = const LatLng(21.210164, 72.851522);
  static const LatLng destination = LatLng(21.203813, 72.765026);

  Future<void> askService() async {
    Location location = Location();
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return;
      }
    }
  }

  Future<void> changePosition() async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition newCameraPosition =
        const CameraPosition(target: destination, zoom: 15);
    debugPrint("moving camera${destination.toString()}");
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    setState(() {});
  }

  final List<Marker> marker = [
    const Marker(
        markerId: MarkerId("1"), position: LatLng(21.210164, 72.851522)),
    const Marker(
        markerId: MarkerId("2"), position: LatLng(21.203813, 72.765026)),
  ];

  @override
  void initState() {
    askService();
    super.initState();
  }

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Track"),
      ),
      body: GoogleMap(
        onTap: (LatLng latLang) {
          setState(() {
            marker.add(Marker(
                icon: BitmapDescriptor.defaultMarker,
                markerId: MarkerId("${marker.length}"),
                position: latLang));
            debugPrint(marker.length.toString());
          });
        },
        polylines: {
          Polyline(
              polylineId: const PolylineId("route"),
              points: [source, destination],
              color: Colors.red,
              width: 5),
        },
        markers: Set<Marker>.of(marker),
        initialCameraPosition: (const CameraPosition(
            zoom: 15, target: LatLng(21.210164, 72.851522))),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: changePosition,
        child: const Icon(Icons.search_outlined),
      ),
    );
  }
}
