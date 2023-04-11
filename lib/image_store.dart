import 'dart:developer';
import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_packages/button_file.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageStore extends StatefulWidget {
  const ImageStore({Key? key}) : super(key: key);

  @override
  State<ImageStore> createState() => _ImageStoreState();
}

class _ImageStoreState extends State<ImageStore> {
  bool isLoading = true;
  File? image1;

  Future<void> takeImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imagePath = File(image.path);
      setState(() {
        image1 = imagePath;
        log(image1!.path);
      });
    } catch (e) {
      log("$e");
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

  Future<void> storeImage(File image1) async {
    Reference reference = FirebaseStorage.instance.ref().child("images/img");
    showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          children: [
            Center(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  Text("Uploading.....")
                ],
              ),
            )
          ],
        );
      },
    );
    await reference.putFile(image1);
    Navigator.of(context).pop();
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
                cameraRequest();
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
            ButtonFile(
                btnText: 'Upload Image',
                btnTap: () {
                  storeImage(image1!).whenComplete(() =>
                      Fluttertoast.showToast(msg: "Image Uploading done"));
                }),
          ],
        ),
      ),
    );
  }
}
