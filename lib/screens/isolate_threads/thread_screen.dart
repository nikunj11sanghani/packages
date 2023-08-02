import 'package:flutter/material.dart';
import 'package:flutter_packages/widgets/button_file.dart';

import '../../routes.dart';

class ThreadScreen extends StatefulWidget {
  const ThreadScreen({Key? key}) : super(key: key);

  @override
  State<ThreadScreen> createState() => _ThreadScreenState();
}

class _ThreadScreenState extends State<ThreadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Performance"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ButtonFile(
              btnText: "ListView",
              btnTap: () {
                Navigator.pushNamed(context, Routes.listViewExample);
              },
            ),
            ButtonFile(
              btnText: "Slivers",
              btnTap: () {
                Navigator.pushNamed(context, Routes.sliverPerformance);
              },
            ),
            ButtonFile(
              btnText: "Staggered Grid",
              btnTap: () {
                Navigator.pushNamed(context, Routes.staggeredGridViewTask);
              },
            ),
            ButtonFile(
              btnText: "Smooth Page Indicator",
              btnTap: () {
                Navigator.pushNamed(context, Routes.smoothPageIndicatorTask);
              },
            ),
          ],
        ),
      ),
    );
  }
}
