import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_packages/button_file.dart';
import 'package:path_provider/path_provider.dart';

class ProviderPath extends StatefulWidget {
  const ProviderPath({Key? key}) : super(key: key);

  @override
  State<ProviderPath> createState() => _ProviderPathState();
}

class _ProviderPathState extends State<ProviderPath> {
  Future<File> localPath() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File("${directory.path}/first_file.txt");
    print(directory.path);
    return file;
  }

  Future<void> writeFile() async {
    final file = await localPath();
    await file.writeAsString("path");
    setState(() {});
  }

  Future<String> readFile() async {
    final file = await localPath();
    return file.readAsString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 58.0),
        child: Center(
          child: Column(
            children: [
              ButtonFile(
                btnText: "Write File",
                btnTap: writeFile,
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder<String>(
                future: readFile(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text("${snapshot.data}");
                  } else {
                    const Text("Error");
                  }
                  return const SizedBox();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
