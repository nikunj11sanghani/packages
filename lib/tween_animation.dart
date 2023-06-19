import 'dart:math';

import 'package:flutter/material.dart';

class TweenAnimation extends StatefulWidget {
  const TweenAnimation({Key? key}) : super(key: key);

  @override
  State<TweenAnimation> createState() => _TweenAnimationState();
}

class _TweenAnimationState extends State<TweenAnimation>
    with SingleTickerProviderStateMixin {
  late Animation animation;
  late Animation animation1;
  late AnimationController animationController;

  @override
  void initState() {
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 10))
          ..repeat();
    animation = Tween(begin: 0.0, end: 2 * pi).animate(animationController);
    animation1 = Tween(begin: 10.0, end: 200.0).animate(animationController);
    animationController.addListener(() {
      setState(() {});
    });
    animationController.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tween Animation"),
      ),
      body: Center(
        child: Column(
          children: [
            Container(
              width: animation1.value,
              height: animation1.value,
              color: Colors.deepOrange,
            ),
            const SizedBox(height: 10),
            AnimatedBuilder(
              animation: animation,
              builder: (BuildContext context, Widget? child) {
                return Transform.rotate(
                  angle: animation.value,
                  child: child,
                );
              },
              child: Container(
                height: 100,
                width: 100,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
