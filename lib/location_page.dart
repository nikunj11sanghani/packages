import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationPage extends StatefulWidget {
  const LocationPage({Key? key}) : super(key: key);

  @override
  State<LocationPage> createState() => _LocationPageState();
}

class _LocationPageState extends State<LocationPage>
    with WidgetsBindingObserver {
  Future<void> getLocation() async {
    LocationPermission p = await Geolocator.checkPermission();
    if (p == LocationPermission.denied ||
        p == LocationPermission.deniedForever) {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Please Allow Location Permission"),
            actions: [
              TextButton(
                  onPressed: () async {
                    await openAppSettings();
                  },
                  child: const Text("Ok"))
            ],
          );
        },
      );
    }
  }

  // Position position = await Geolocator.getCurrentPosition(
  // desiredAccuracy: LocationAccuracy.best);
  // log("Longitude${position.longitude}");
  // log("latitude${position.latitude}");
  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    LocationPermission p = await Geolocator.checkPermission();
    if (state == AppLifecycleState.resumed) {
      if (p == LocationPermission.whileInUse ||
          p == LocationPermission.always) {
        Navigator.of(context).pop();
      }
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GeoLocation"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: getLocation,
          child: const Text("Get The Location"),
        ),
      ),
    );
  }
}
