import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_packages/button_file.dart';
import 'package:flutter_packages/cached_network.dart';
import 'package:flutter_packages/image_package.dart';
import 'package:flutter_packages/launch_url.dart';
import 'package:flutter_packages/loading_package.dart';
import 'package:flutter_packages/location_page.dart';
import 'package:flutter_packages/map_page.dart';
import 'package:flutter_packages/picker_file.dart';
import 'package:flutter_packages/player_video.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'notificationservice/local_notification_service.dart';

class PickerImage extends StatefulWidget {
  const PickerImage({Key? key}) : super(key: key);

  @override
  State<PickerImage> createState() => _PickerImageState();
}

class _PickerImageState extends State<PickerImage> with WidgetsBindingObserver {
  bool isFromStorage = false;

  compulsoryPermission(bool isFromStorage) async {
    PermissionStatus firstPermission = await Permission.camera.status;
    if (!firstPermission.isGranted) {
      await Permission.camera.request();
    }
    if (firstPermission.isGranted) {
      return;
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    isFromStorage = true;
                    await openAppSettings();
                    if (await Permission.camera.isGranted) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Open Settings")),
            ],
            title: const Text("Permission Camera"),
          );
        },
      );
    }
  }

  @override
  void initState() {
    compulsoryPermission(false);
    WidgetsBinding.instance.addObserver(this);
    FirebaseCrashlytics.instance.setCustomKey("Check", "Crash");
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        log("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          log("New Notification");
        }
      },
    );
    FirebaseMessaging.onMessage.listen(
      //forGround
      (message) {
        log("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          log("${message.notification!.title}");
          log("${message.notification!.body}");
          log("message.data11 ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      //backGround
      (message) {
        final keyValue = message.data['Open App'];
        log(keyValue);
        if (message.notification != null) {
          log("${message.notification!.title}");
          log("${message.notification!.body}");
          log("message.data22 ${message.data['_id']}");
        }
      },
    );
    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Permission.camera.status.isGranted && isFromStorage) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      }
    }
    super.didChangeAppLifecycleState(state);
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
        title: const Text("Image Picker"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ButtonFile(
                btnText: 'Image Package',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ImagePackage()));
                },
              ),
              ButtonFile(
                btnText: 'Video Player Page',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PlayerVideo()));
                },
              ),
              ButtonFile(
                btnText: 'Pick file',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const PickerFile()));
                },
              ),
              ButtonFile(
                btnText: 'Path Provider',
                btnTap: () {
                  FirebaseCrashlytics.instance.crash();

                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => const ProviderPath()));
                },
              ),
              ButtonFile(
                btnText: 'Launch URL Package',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LaunchUrl()));
                },
              ),
              ButtonFile(
                btnText: 'Cached Network Image',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CachedNetwork()));
                },
              ),
              ButtonFile(
                btnText: 'GeoLocator',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LocationPage()));
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ButtonFile(
                    btnText: 'Default Toast',
                    btnTap: defaultToast,
                  ),
                  ButtonFile(
                    btnText: 'Custom Toast',
                    btnTap: customToast,
                  ),
                ],
              ),
              ButtonFile(
                btnText: 'Easy Loading',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoadingCustom()));
                },
              ),
              ButtonFile(
                btnText: 'Google Maps',
                btnTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const MapPage()));
                },
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
                            Image.asset("assets/images/home_bg.png",
                                fit: BoxFit.fill,
                                height: 100,
                                width: double.infinity),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                            Image.asset("assets/images/home_bg.png",
                                fit: BoxFit.fill,
                                height: 100,
                                width: double.infinity),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
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
                    ),
                  ],
                  options: CarouselOptions(
                      viewportFraction: 1, autoPlay: false, height: 302))
            ],
          ),
        ),
      ),
    );
  }

  defaultToast() async {
    Fluttertoast.showToast(
        msg: "Default Toast Message",
        fontSize: 15,
        textColor: Colors.white,
        backgroundColor: Colors.black,
        gravity: ToastGravity.BOTTOM);
  }

  customToast() async {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      height: 50,
      decoration: BoxDecoration(
          color: Colors.deepOrange, borderRadius: BorderRadius.circular(10)),
      child: const Row(
        children: [Icon(Icons.done_all), Text("Custom Toast Message")],
      ),
    );
    fToast.showToast(child: toast, toastDuration: const Duration(seconds: 3));
  }
}
