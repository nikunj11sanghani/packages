import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as l;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng source = const LatLng(23.042553, 72.501352);
  LatLng destination = const LatLng(23.042000, 72.498604);

  LatLng currentLoc = const LatLng(0, 0);

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> askService() async {
    l.Location location = l.Location();
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return;
      }
    }

    location.onLocationChanged.listen((l.LocationData locationData) {
      setState(() {
        currentLoc = LatLng(locationData.latitude!, locationData.longitude!);
        marker.add(Marker(
            markerId: const MarkerId("Current Location"),
            position: currentLoc,
            infoWindow: const InfoWindow(title: "Current Location")));
        moveCamera(currentLoc);
      });
    });
  }

  Future<void> moveCamera(LatLng latLng) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition newCameraPosition = CameraPosition(target: latLng, zoom: 15);
    debugPrint("moving camera${latLng.toString()}");
    await controller
        .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));
    setState(() {});
  }

  final List<Marker> marker = [];

  Future<String> getAddressFromLatLng(LatLng latLng) async {
    List<Placemark> placeMarks =
        await placemarkFromCoordinates(latLng.latitude, latLng.longitude);
    if (placeMarks.isNotEmpty) {
      Placemark first = placeMarks.first;
      return "${first.name}, ${first.thoroughfare}, ${first.locality}, ${first.postalCode}, ${first.country}";
    } else {
      return 'Address not found';
    }
  }

  @override
  void initState() {
    askService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Track"),
      ),
      body: GoogleMap(
        onMapCreated: (controller) => _controller.complete(controller),
        onTap: (LatLng latLang) async {
          final address = await getAddressFromLatLng(latLang);
          setState(() {
            marker.add(Marker(
                infoWindow:
                    InfoWindow(title: "Your  Destination", snippet: address),
                icon: BitmapDescriptor.defaultMarker,
                markerId: MarkerId("${marker.length + 1}"),
                position: latLang));
            destination = latLang;
            debugPrint(marker.length.toString());
          });
        },
        markers: Set<Marker>.of(marker),
        initialCameraPosition: (CameraPosition(zoom: 15, target: currentLoc)),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          moveCamera(currentLoc);
          setState(() {});
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
