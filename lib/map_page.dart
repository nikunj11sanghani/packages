import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
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
            zoomControlsEnabled: false,
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
          CarouselSlider(
              items: [
                SizedBox(
                  width: 300,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    clipBehavior: Clip.hardEdge,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            Image.asset("assets/images/home_bg.png",
                                fit: BoxFit.fill,
                                height: 100,
                                width: double.infinity),
                            const CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(Icons.directions,
                                  color: Colors.orangeAccent),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Universe Medicos"),
                                  const SizedBox(
                                    height: 5,
                                  ),
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
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.water_damage,
                                          color: Colors.green),
                                      Text("Available 5 out of 10")
                                    ],
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.call,
                                          color: Colors.deepPurpleAccent),
                                      Text("+91 9328646220")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.deepPurpleAccent),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Call",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.deepPurpleAccent),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3))),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text("View Details",
                                          style: TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontSize: 13)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 300,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    clipBehavior: Clip.hardEdge,
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Image.asset("assets/images/home_bg.png",
                                fit: BoxFit.fill,
                                height: 100,
                                width: double.infinity),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.white,
                                    child: Icon(Icons.directions,
                                        color: Colors.orangeAccent, size: 18),
                                  ),
                                ),
                                Card(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  clipBehavior: Clip.hardEdge,
                                  elevation: 5,
                                  child: const Text("Partial"),
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text("Universe Medicos"),
                                  const SizedBox(
                                    height: 5,
                                  ),
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
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.water_damage,
                                          color: Colors.green),
                                      Text("Available 5 out of 10")
                                    ],
                                  ),
                                  const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Icon(Icons.call,
                                          color: Colors.deepPurpleAccent),
                                      Text("+91 9328646220")
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 30,
                                    decoration: const BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5)),
                                        color: Colors.deepPurpleAccent),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Call",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        SizedBox(
                                          width: 2,
                                        ),
                                        Icon(
                                          Icons.call,
                                          color: Colors.white,
                                        )
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Container(
                                    width: 80,
                                    height: 30,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: Colors.deepPurpleAccent),
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(3))),
                                    child: const Align(
                                      alignment: Alignment.center,
                                      child: Text("View Details",
                                          style: TextStyle(
                                              color: Colors.deepPurpleAccent,
                                              fontSize: 13)),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              options: CarouselOptions(
                  viewportFraction: 1, autoPlay: false, height: 220))
        ],
      ),
    );
  }
}
