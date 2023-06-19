import 'package:flutter/material.dart';

class HeroNavigation extends StatefulWidget {
  const HeroNavigation({Key? key}) : super(key: key);

  @override
  State<HeroNavigation> createState() => _HeroNavigationState();
}

class _HeroNavigationState extends State<HeroNavigation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero Navigation"),
      ),
      body: Center(
        child: Hero(
          tag: "First",
          child: Container(
            width: 200,
            height: 200,
            color: Colors.deepOrange,
          ),
        ),
      ),
    );
  }
}
