import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_packages/widgets/button_file.dart';

class PickerFile extends StatefulWidget {
  const PickerFile({Key? key}) : super(key: key);

  @override
  State<PickerFile> createState() => _PickerFileState();
}

class _PickerFileState extends State<PickerFile> {
  // PlatformFile? file;
  File? lastFile;
  FilePickerResult? filePickerResult;

  Future<void> takeFile() async {
    filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );
    if (filePickerResult != null) {
      PlatformFile file = filePickerResult!.files.first;
      lastFile = File(file.path.toString());
      log("${file.path}");
      log("${file.size}");
      log(file.name);
      log("${file.bytes}");
      log("${file.extension}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Column(
          children: [
            Center(
              child: ButtonFile(
                btnText: 'Pick File',
                btnTap: takeFile,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
