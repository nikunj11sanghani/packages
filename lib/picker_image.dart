import 'dart:developer';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_packages/animated_opacity_task.dart';
import 'package:flutter_packages/button_file.dart';
import 'package:flutter_packages/cached_network.dart';
import 'package:flutter_packages/hero_animation.dart';
import 'package:flutter_packages/image_package.dart';
import 'package:flutter_packages/info_package.dart';
import 'package:flutter_packages/intl_package.dart';
import 'package:flutter_packages/launch_url.dart';
import 'package:flutter_packages/loading_package.dart';
import 'package:flutter_packages/location_page.dart';
import 'package:flutter_packages/picker_file.dart';
import 'package:flutter_packages/player_video.dart';
import 'package:flutter_packages/store_file.dart';
import 'package:flutter_packages/tween_animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'notificationservice/local_notification_service.dart';

class PickerImage extends StatefulWidget {
  const PickerImage({Key? key}) : super(key: key);

  @override
  State<PickerImage> createState() => _PickerImageState();
}

class _PickerImageState extends State<PickerImage> with WidgetsBindingObserver {
  compulsoryPermission() async {
    PermissionStatus firstPermission = await Permission.camera.status;
    if (!firstPermission.isGranted) {
      await Permission.camera.request();
    } else if (firstPermission.isGranted) {
      return;
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        // barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    await openAppSettings();
                  },
                  child: const Text("Open Settings")),
            ],
            title: const Text("Permission Required"),
          );
        },
      );
    }
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Permission.camera.status.isGranted) {}
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void initState() {
    compulsoryPermission();
    WidgetsBinding.instance.addObserver(this);
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
    FirebaseCrashlytics.instance.setCustomKey("Check", "Crash");
    //terminated
    FirebaseMessaging.instance.getInitialMessage().then(
      (message) {
        log("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          log("New Notification");
        }
      },
    );
    //forGround
    FirebaseMessaging.onMessage.listen(
      (message) {
        log("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          log("notification title${message.notification!.title}");
          log("notification body${message.notification!.body}");
          log("message.data ${message.data}");
          LocalNotificationService.displayNotification(message);
        }
      },
    );
    //backGround
    FirebaseMessaging.onMessageOpenedApp.listen(
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
              ButtonFile(
                btnText: 'Default Toast',
                btnTap: defaultToast,
              ),
              ButtonFile(
                btnText: 'Custom Toast',
                btnTap: customToast,
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
                btnText: 'Information',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InfoPackages()));
                },
              ),
              ButtonFile(
                btnText: 'Fire Store',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const StoreFile()));
                },
              ),
              ButtonFile(
                btnText: 'Intl Package',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IntlPackage()));
                },
              ),
              ButtonFile(
                btnText: 'Tween Animation',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TweenAnimation()));
                },
              ),
              ButtonFile(
                btnText: 'HERO Animation',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HeroAnimation()));
                },
              ),
              ButtonFile(
                btnText: 'Animated Widgets',
                btnTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AnimatedOpacityTask()));
                },
              ),
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
