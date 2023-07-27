import 'dart:developer';
import 'package:flutter_packages/routes.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_packages/widgets/button_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';

import '../notificationservice/local_notification_service.dart';

class PickerImage extends StatefulWidget {
  const PickerImage({Key? key}) : super(key: key);

  @override
  State<PickerImage> createState() => _PickerImageState();
}

class _PickerImageState extends State<PickerImage> with WidgetsBindingObserver {
  final localAuthentication = LocalAuthentication();
  bool hasEnrolled = true;

  Future<bool> checkBiometric() async {
    final List<BiometricType> availableBiometrics =
        await localAuthentication.getAvailableBiometrics();
    log(availableBiometrics.toString());
    return await localAuthentication.canCheckBiometrics ||
        await localAuthentication.isDeviceSupported();
  }

  Future<bool> authenticate() async {
    try {
      if (!await checkBiometric()) {
        return false;
      }

      final List<BiometricType> availableBiometrics =
          await localAuthentication.getAvailableBiometrics();
      if (availableBiometrics.isEmpty) {
        setState(() {
          hasEnrolled = false;
        });
      }
      return await localAuthentication.authenticate(
          localizedReason: "Required",
          authMessages: <AuthMessages>[
            const AndroidAuthMessages(
              signInTitle: 'Oops! Biometric authentication required!',
              cancelButton: 'No thanks',
            ),
            const IOSAuthMessages(
              cancelButton: 'No thanks',
            ),
          ],
          options: const AuthenticationOptions(
            biometricOnly: true,
            stickyAuth: true,
            useErrorDialogs: true,
          ));
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  compulsoryPermission() async {
    PermissionStatus firstPermission = await Permission.camera.status;
    if (!firstPermission.isGranted) {
      await Permission.camera.request();
    } else if (firstPermission.isGranted) {
      return;
    } else {
      if (mounted) {
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.count(
            padding: const EdgeInsets.all(20),
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 3,
            children: [
              ButtonFile(
                btnText: 'Image Package',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.imagePackage);
                },
              ),
              ButtonFile(
                btnText: 'Video Player Page',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.playerVideo);
                },
              ),
              ButtonFile(
                btnText: 'Pick file',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.pickerFile);
                },
              ),
              ButtonFile(
                btnText: 'Path Provider',
                btnTap: () {
                  FirebaseCrashlytics.instance.crash();

                  // Navigator.pushNamed(context, routeName)(
                  //     context,Routes.;
                },
              ),
              ButtonFile(
                btnText: 'Launch URL Package',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.launchUrl);
                },
              ),
              ButtonFile(
                btnText: 'Cached Network Image',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.cachedNetwork);
                },
              ),
              ButtonFile(
                btnText: 'GeoLocator',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.locationPage);
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
                  Navigator.pushNamed(context, Routes.loadingCustom);
                },
              ),
              ButtonFile(
                btnText: 'Information',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.infoPackages);
                },
              ),
              ButtonFile(
                btnText: 'Fire Store',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.storeFile);
                },
              ),
              ButtonFile(
                btnText: 'Intl Package',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.intlPackage);
                },
              ),
              ButtonFile(
                btnText: 'Tween Animation',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.tweenAnimation);
                },
              ),
              ButtonFile(
                btnText: 'HERO Animation',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.heroAnimation);
                },
              ),
              ButtonFile(
                btnText: 'Animated Widgets',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.animatedOpacityTask);
                },
              ),
              Visibility(
                visible: hasEnrolled,
                child: ButtonFile(
                  btnText: 'Local Authentication',
                  btnTap: () async {
                    bool isAvailable = await authenticate();
                    if (isAvailable) {
                      if (mounted) {
                        Navigator.pushNamed(context, Routes.localAuthTask);
                      }
                    }
                  },
                ),
              ),
              ButtonFile(
                btnText: 'Sliver Task',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.sliverTask);
                },
              ),
              ButtonFile(
                btnText: 'Shimmer Effect',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.shimmerTask);
                },
              ),
              ButtonFile(
                btnText: 'Pin Code Screen',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.phoneScreen);
                },
              ),
              ButtonFile(
                btnText: 'Flutter Form Field',
                btnTap: () {
                  Navigator.pushNamed(context, Routes.formScreen);
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
