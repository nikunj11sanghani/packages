import 'dart:developer';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_packages/button_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePackage extends StatefulWidget {
  const ImagePackage({Key? key}) : super(key: key);

  @override
  State<ImagePackage> createState() => _ImagePackageState();
}

class _ImagePackageState extends State<ImagePackage>
    with WidgetsBindingObserver {
  File? image1;
  bool isFromStorage = false;

  Future<void> takeImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePath = File(image.path);
      setState(() {
        image1 = imagePath;
      });
    } catch (e) {
      log("$e");
    }
  }

  storageRequest() async {
    PermissionStatus storageStatus = await Permission.storage.request();
    if (storageStatus == PermissionStatus.granted) {
      takeImage(ImageSource.gallery);
    }
    if (storageStatus == PermissionStatus.denied) {
      log("Permission Required");
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  compulsoryPermission(bool isFromStorage) async {
    PermissionStatus firstPermission = await Permission.camera.status;
    // PermissionStatus secondPermission = await Permission.storage.request();
    if (!firstPermission.isGranted) {
      await Permission.camera.request();
      // await Permission.storage.request();
    }
    // firstPermission = await Permission.camera.status;
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
                    if (await Permission.camera.isGranted) {
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    }
                    await openAppSettings();
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
        title: const Text("Image Package"),
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: image1 == null
                  ? const Text("Select Image")
                  : Image.file(
                      height: 200,
                      width: 200,
                      image1!,
                    ),
            ),
            ButtonFile(
              btnText: 'Take Image from Camera',
              btnTap: () {
                FirebaseAnalytics.instance.logEvent(
                    name: "Image Camera", parameters: {"Package": "Camera"});
                isFromStorage = false;
                takeImage(ImageSource.camera);
              },
            ),
            ButtonFile(
                btnText: 'Take Image from Gallery',
                btnTap: () {
                  FirebaseAnalytics.instance.logEvent(
                      name: "Image Gallery",
                      parameters: {"Package": "Gallery"});
                  storageRequest();
                }),
          ],
        ),
      ),
    );
  }
}
