import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as l;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng currentLoc = const LatLng(23.042553, 72.501352);
  bool hasChange = true;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  String address = "";

  Future<void> askService() async {
    l.Location location = l.Location();
    bool isServiceEnabled = await location.serviceEnabled();
    if (!isServiceEnabled) {
      isServiceEnabled = await location.requestService();
      if (!isServiceEnabled) {
        return;
      }
    }

    Geolocator.getPositionStream().listen((Position currentLocation) {
      if (hasChange) {
        setState(() {
          currentLoc =
              LatLng(currentLocation.latitude, currentLocation.longitude);
          debugPrint("$currentLoc");
          moveCamera(currentLoc);
        });
      }
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
        title: const Text("Medical App"),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          GoogleMap(
            onMapCreated: (controller) => _controller.complete(controller),
            onTap: (LatLng latLang) async {
              String newAddress = await getAddressFromLatLng(latLang);
              setState(() {
                hasChange = false;
                currentLoc = latLang;
                address = newAddress;
              });
              moveCamera(currentLoc);
            },
            markers: {
              Marker(
                  markerId: const MarkerId("Current Location"),
                  position: currentLoc,
                  infoWindow:
                      InfoWindow(snippet: address, title: "Current Location"))
            },
            initialCameraPosition:
                (CameraPosition(zoom: 15, target: currentLoc)),
          ),
          SizedBox(
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/images/home_bg.png",
                    fit: BoxFit.contain, height: 100),
                Row(
                  children: [
                    Column(
                      children: [
                        const Text("Universe Medicos"),
                        RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "Pharmacist -",
                              style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.black)),
                          TextSpan(
                              text: "Amit Sharma",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black))
                        ])),
                        const Row(
                          children: [
                            Icon(Icons.water_damage),
                            Text("Available 5 out of 10")
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
