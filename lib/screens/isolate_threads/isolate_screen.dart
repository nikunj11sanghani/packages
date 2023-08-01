import 'dart:isolate';

import 'package:flutter/material.dart';

class IsolateScreen extends StatefulWidget {
  const IsolateScreen({Key? key}) : super(key: key);

  @override
  State<IsolateScreen> createState() => _IsolateScreenState();
}

class _IsolateScreenState extends State<IsolateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Isolate"),
      ),
      body: Center(
        child: Column(
          children: [
            const CircularProgressIndicator(),
            ElevatedButton(
                onPressed: () async {
                  var total = await noIsolate();
                  debugPrint(total.toString());
                },
                child: const Text("Without Isolates")),
            ElevatedButton(
                onPressed: () async {
                  final receivePort = ReceivePort();
                  await Isolate.spawn(withIsolate, receivePort.sendPort);
                  receivePort.listen((total) {
                    debugPrint(total.toString());
                  });
                },
                child: const Text("With Isolates")),
          ],
        ),
      ),
    );
  }

  Future<double> noIsolate() async {
    var total = 0.0;
    for (var i = 0; i < 999999999; i++) {
      total += i;
    }
    return total;
  }
}

withIsolate(SendPort sendPort) {
  var total = 0.0;
  for (var i = 0; i < 999999999; i++) {
    total += i;
  }
  sendPort.send(total);
}
