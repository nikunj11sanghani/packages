import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class Video1Player extends StatefulWidget {
  const Video1Player({Key? key}) : super(key: key);

  @override
  State<Video1Player> createState() => _Video1PlayerState();
}

class _Video1PlayerState extends State<Video1Player> {
  File? video;
  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  Future<void> getVideo(ImageSource source) async {
    try {
      final video1 = await ImagePicker().pickVideo(source: source);
      video = File(video1!.path);

      videoPlayerController = VideoPlayerController.file(video!)
        ..initialize().then(
          (_) {
            setState(() {});
            videoPlayerController!.play();
            chewieController = ChewieController(
                videoPlayerController: videoPlayerController!, looping: false);
          },
        );
    } catch (e) {
      log("$e");
    }
  }

  Future<void> cameraRequest() async {
    PermissionStatus cameraStatus = await Permission.camera.request();
    if (cameraStatus == PermissionStatus.granted) {
      getVideo(ImageSource.camera);
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
      getVideo(ImageSource.gallery);
    }
    if (storageStatus == PermissionStatus.denied) {
      log("Permission Required");
    }
    if (storageStatus == PermissionStatus.permanentlyDenied) {
      openAppSettings();
    }
  }

  @override
  void dispose() {
    videoPlayerController!.dispose();
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          const SizedBox(
            height: 50,
          ),
          video != null
              ? AspectRatio(
                  aspectRatio: 3 / 2,
                  child: Chewie(
                    controller: chewieController!,
                  ),
                )
              : const Text("Select The video"),
          ElevatedButton(
              onPressed: cameraRequest,
              child: const Text("Take A video From Camera")),
          ElevatedButton(
              onPressed: storageRequest,
              child: const Text("Take A video From Gallery"))
        ]),
      ),
    );
  }
}
