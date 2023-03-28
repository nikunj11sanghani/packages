import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_packages/file_picker.dart';
import 'package:flutter_packages/url_launch.dart';
import 'package:flutter_packages/video_player.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class Image1Picker extends StatefulWidget {
  const Image1Picker({Key? key}) : super(key: key);

  @override
  State<Image1Picker> createState() => _Image1PickerState();
}

class _Image1PickerState extends State<Image1Picker> {
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

  Future<void> cameraRequest() async {
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

  Future<void> storageRequest() async {
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
            ElevatedButton(
                onPressed: cameraRequest,
                child: const Text("Take Image from Camera")),
            ElevatedButton(
                onPressed: storageRequest,
                child: const Text("Take Image from Gallery")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Video1Player()));
                },
                child: const Text("Video Player Page")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const File1Picker()));
                },
                child: const Text("Pick file")),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const UrlLaunch()));
                },
                child: const Text("Launch URL Package")),
          ],
        ),
      ),
    );
  }
}
