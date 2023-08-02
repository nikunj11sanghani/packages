import 'package:flutter/material.dart';
import 'package:flutter_packages/hero_navigation.dart';
import 'package:flutter_packages/routes.dart';

class HeroAnimation extends StatefulWidget {
  const HeroAnimation({Key? key}) : super(key: key);

  @override
  State<HeroAnimation> createState() => _HeroAnimationState();
}

class _HeroAnimationState extends State<HeroAnimation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Hero Animation"),
      ),
      body: Center(
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
                context,Routes.heroNavigation);
          },
          child: Hero(
            tag: "First",
            child: Container(
              height: 100,
              color: Colors.deepOrange,
              width: 100,
            ),
          ),
        ),
      ),
    );
  }
}
