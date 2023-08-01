import 'package:flutter/material.dart';

class AnimatedItemText extends StatefulWidget {
  final int index;

  const AnimatedItemText({super.key, required this.index});

  @override
  _AnimatedItemTextState createState() => _AnimatedItemTextState();
}

class _AnimatedItemTextState extends State<AnimatedItemText>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration:
          const Duration(milliseconds: 2000), // Set the animation duration
    );

    _fadeInAnimation = Tween<double>(begin: 0.0, end: 0.5).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    // Start the animation when this widget is created
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeInAnimation,
      child: Text("Item ${widget.index}"),
    );
  }
}
