import 'package:flutter/material.dart';
import 'package:flutter_packages/screens/isolate_threads/list_view_task.dart';
import 'package:flutter_packages/screens/isolate_threads/sliver_performance.dart';
import 'package:flutter_packages/widgets/button_file.dart';

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
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ListViewExample(),
                    ));
              },
            ),
            ButtonFile(
              btnText: "Slivers",
              btnTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SliverPerformance(),
                    ));
              },
            ),
          ],
        ),
      ),
    );
  }
}
