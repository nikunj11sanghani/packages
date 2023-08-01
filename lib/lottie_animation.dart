import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LottieAnimation extends StatefulWidget {
  const LottieAnimation({Key? key}) : super(key: key);

  @override
  State<LottieAnimation> createState() => _LottieAnimationState();
}

class _LottieAnimationState extends State<LottieAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(vsync: this);

    controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pop(context);
        controller.reset();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lottie Animation"),
      ),
      body: PageView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Lottie.asset(
                repeat: true,
                "assets/animation/animation${index + 1}.json",
              ),
              ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => SizedBox(
                        height: 200,
                        width: 200,
                        child: Dialog(
                          child: Column(
                            children: [
                              Lottie.asset(
                                "assets/animation/animation_lkrzzd6s.json",
                                controller: controller,
                                onLoaded: (p0) {
                                  controller.duration = p0.duration;
                                  controller.forward();
                                },
                              ),
                              const Text("Done")
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  child: const Text("Done"))
            ],
          );
        },
      ),
    );
  }
}
