import 'package:flutter/material.dart';

import 'animated_text.dart';

class ListViewExample extends StatefulWidget {
  const ListViewExample({Key? key}) : super(key: key);

  @override
  State<ListViewExample> createState() => _ListViewExampleState();
}

class _ListViewExampleState extends State<ListViewExample> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("List View Performance"),
      ),
      body: ListView(
        children: List.generate(2000, (index) => buildAnimatedItem(index)),
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
