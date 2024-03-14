import 'dart:async';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as l;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late LatLng currentLoc;
  bool hasChange = true;
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  Future<void> getCurrentLocation() async {
    Position position = await GeolocatorPlatform.instance.getCurrentPosition();
    setState(() {
      currentLoc = LatLng(position.latitude, position.longitude);
    });
  }

  late Future<void> _currentLocationFuture;

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

  @override
  void initState() {
    askService();
    _currentLocationFuture = getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Medical App"),
      ),
      body: FutureBuilder(
        future: _currentLocationFuture,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                GoogleMap(
                  onMapCreated: (controller) =>
                      _controller.complete(controller),
                  onTap: (LatLng latLang) async {
                    setState(() {
                      hasChange = false;
                      currentLoc = latLang;
                    });
                    moveCamera(currentLoc);
                  },
                  markers: {
                    Marker(
                        markerId: const MarkerId("Current Location"),
                        position: currentLoc,
                        infoWindow: const InfoWindow(title: "Current Location"))
                  },
                  initialCameraPosition:
                      (CameraPosition(zoom: 15, target: currentLoc)),
                ),
                CarouselSlider(
                    items: [
                      Card(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.directions,
                                            color: Colors.orangeAccent,
                                            size: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      height: 30,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        clipBehavior: Clip.hardEdge,
                                        elevation: 5,
                                        child: const Align(
                                            alignment: Alignment.center,
                                            child: Text("Partial")),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                style: TextStyle(
                                                    color: Colors.white)),
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3))),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text("View Details",
                                              style: TextStyle(
                                                  color:
                                                      Colors.deepPurpleAccent,
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
                      Card(
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.white,
                                        child: Icon(Icons.directions,
                                            color: Colors.orangeAccent,
                                            size: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 60,
                                      height: 30,
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        clipBehavior: Clip.hardEdge,
                                        elevation: 5,
                                        child: const Align(
                                            alignment: Alignment.center,
                                            child: Text("Partial")),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                                style: TextStyle(
                                                    color: Colors.white)),
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
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(3))),
                                        child: const Align(
                                          alignment: Alignment.center,
                                          child: Text("View Details",
                                              style: TextStyle(
                                                  color:
                                                      Colors.deepPurpleAccent,
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
                    ],
                    options: CarouselOptions(
                        viewportFraction: 0.9,
                        aspectRatio: 2.0,
                        autoPlay: false,
                        height: 230))
              ],
            );
          }
        },
      ),
    );
  }
}
