import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class File1Picker extends StatefulWidget {
  const File1Picker({Key? key}) : super(key: key);

  @override
  State<File1Picker> createState() => _File1PickerState();
}

class _File1PickerState extends State<File1Picker> {
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
      print(file.path);
      print(file.size);
      print(file.name);
      print(file.bytes);
      print(file.extension);
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
              child: TextButton(
                  onPressed: takeFile, child: const Text("Pick File")),
            ),
          ],
        ),
      ),
    );
  }
}
