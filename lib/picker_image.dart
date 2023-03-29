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

class _PickerImageState extends State<PickerImage> {
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
      print(e);
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

  requiredPermission() async {
    PermissionStatus firstPermission = await Permission.camera.request();
    PermissionStatus secondPermission = await Permission.storage.request();
    if (firstPermission.isGranted && secondPermission.isGranted) {
      return;
    } else {
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              OutlinedButton(
                  onPressed: () async {
                    await openAppSettings();
                  },
                  child: const Text("Yes")),
              OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("No")),
            ],
            title: const Text("Permission Required"),
          );
        },
      );
    }
  }

  @override
  void initState() {
    requiredPermission();
    super.initState();
  }

  @override
  void dispose() {
    requiredPermission().dispose();
    cameraRequest().dispose();
    storageRequest().dispose();
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
