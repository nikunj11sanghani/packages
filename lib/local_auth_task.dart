import 'package:flutter/material.dart';

class LocalAuthTask extends StatefulWidget {
  const LocalAuthTask({Key? key}) : super(key: key);

  @override
  State<LocalAuthTask> createState() => _LocalAuthTaskState();
}

class _LocalAuthTaskState extends State<LocalAuthTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Local Authentication"),
      ),
      body: const Center(
        child: Column(
          children: [Text("Welcome")],
        ),
      ),
    );
  }
}
