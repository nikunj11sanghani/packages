import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_packages/button_file.dart';
import 'package:flutter_packages/launch_url.dart';
import 'package:flutter_packages/picker_file.dart';
import 'package:flutter_packages/player_video.dart';
import 'package:flutter_packages/provider_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class PickerImage extends StatefulWidget {
  const PickerImage({Key? key}) : super(key: key);

  @override
  State<PickerImage> createState() => _PickerImageState();
}

class _PickerImageState extends State<PickerImage> with WidgetsBindingObserver {
  File? image1;

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

  cameraRequest() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    if (cameraStatus == PermissionStatus.granted) {
      takeImage(ImageSource.camera);
    }
    if (cameraStatus == PermissionStatus.denied) {
      log("Permission Required");
    }
    if (cameraStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
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

  compulsoryPermission() async {
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
      if (context.mounted) return;
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            actions: [
              OutlinedButton(
                  onPressed: () async {
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
    compulsoryPermission();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (await Permission.camera.status.isGranted) {
      if (context.mounted) return;
      Navigator.pop(context);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    compulsoryPermission().dispose();
    cameraRequest().dispose();
    storageRequest().dispose();
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
        child: Column(
          children: [
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: image1 != null
                    ? Image.file(
                        height: 100,
                        width: 100,
                        image1!,
                      )
                    : const Text("Select Image"),
              ),
            ),
            ButtonFile(
              btnText: 'Take Image from Camera',
              btnTap: cameraRequest,
            ),
            ButtonFile(
              btnText: 'Take Image from Gallery',
              btnTap: storageRequest,
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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProviderPath()));
              },
            ),
            ButtonFile(
              btnText: 'Launch URL Package',
              btnTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const LaunchUrl()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
