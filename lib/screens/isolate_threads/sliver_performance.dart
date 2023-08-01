import 'package:flutter/material.dart';
import 'package:flutter_packages/screens/isolate_threads/animated_text.dart';

class SliverPerformance extends StatefulWidget {
  const SliverPerformance({Key? key}) : super(key: key);

  @override
  State<SliverPerformance> createState() => _SliverPerformanceState();
}

class _SliverPerformanceState extends State<SliverPerformance> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sliver Performance"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildBuilderDelegate(
            childCount: 2000,
            (context, index) => buildAnimatedItem(index),
          ))
        ],
      ),
    );
  }

  Widget buildAnimatedItem(int index) {
    return Center(
      child: AnimatedItemText(
        index: index,
      ),
    );
  }
}
