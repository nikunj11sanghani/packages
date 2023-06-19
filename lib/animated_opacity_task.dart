import 'package:flutter/material.dart';

class AnimatedOpacityTask extends StatefulWidget {
  const AnimatedOpacityTask({Key? key}) : super(key: key);

  @override
  State<AnimatedOpacityTask> createState() => _AnimatedOpacityState();
}

class _AnimatedOpacityState extends State<AnimatedOpacityTask> {
  double opacity = 1.0;
  double paddingVal = 0.0;

  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animated Opacity"),
      ),
      body: Center(
        child: Column(
          children: [
            AnimatedOpacity(
              opacity: opacity,
              duration: const Duration(seconds: 3),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.deepOrange,
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    opacity = opacity == 1.0 ? 0.5 : 1.0;
                  });
                },
                child: const Text("Change Opacity")),

            AnimatedPadding(
              padding: EdgeInsets.all(paddingVal),
              duration: const Duration(seconds: 3),
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width,
                color: Colors.deepOrange,
              ),
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    paddingVal = paddingVal == 0.0 ? 100.0 : 0.0;
                  });
                },
                child: const Text("Change Padding")),
            AnimatedSwitcher(

              duration: const Duration(milliseconds: 500),
              child: Text("$count",key: ValueKey(count)),

            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    count += 1;
                  });
                },
                child: const Text("Switcher")),
          ],
        ),
      ),
    );
  }
}
