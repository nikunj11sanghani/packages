import 'dart:developer';
import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_packages/widgets/button_file.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class PlayerVideo extends StatefulWidget {
  const PlayerVideo({Key? key}) : super(key: key);

  @override
  State<PlayerVideo> createState() => _PlayerVideoState();
}

class _PlayerVideoState extends State<PlayerVideo> {
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
          ButtonFile(
            btnText: 'Take a video From Camera',
            btnTap: cameraRequest,
          ),
          ButtonFile(
            btnText: 'Take A video From Gallery',
            btnTap: storageRequest,
          )
        ]),
      ),
    );
  }
}
