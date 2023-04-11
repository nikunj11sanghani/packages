import 'package:flutter/material.dart';

class DioExample extends StatefulWidget {
  const DioExample({Key? key}) : super(key: key);

  @override
  State<DioExample> createState() => _DioExampleState();
}

class _DioExampleState extends State<DioExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dio Package"),
      ),
    );
  }
}
