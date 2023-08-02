import 'package:flutter/material.dart';
import 'package:flutter_packages/widgets/helper_container.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class SmoothPageIndicatorTask extends StatefulWidget {
  const SmoothPageIndicatorTask({Key? key}) : super(key: key);

  @override
  State<SmoothPageIndicatorTask> createState() =>
      _SmoothPageIndicatorTaskState();
}

class _SmoothPageIndicatorTaskState extends State<SmoothPageIndicatorTask> {
  final List colors = [
    Colors.lime,
    Colors.cyan,
    Colors.lightGreen,
    Colors.deepOrangeAccent,
    Colors.deepPurple,
  ];
  PageController controller =
      PageController(viewportFraction: 0.9, keepPage: false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Smooth Page Indicator"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 240,
                child: PageView.builder(
                  controller: controller,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return HelperContainer(colors: colors[index], text: "");
                  },
                ),
              ),
              SmoothPageIndicator(
                controller: controller,
                count: colors.length,
                effect: const WormEffect(
                  dotHeight: 16,
                  dotWidth: 16,
                  type: WormType.underground,
                  activeDotColor: Colors.deepOrange,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SmoothPageIndicator(
                controller: controller,
                count: colors.length,
                effect: const ExpandingDotsEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: Colors.deepOrange,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SmoothPageIndicator(
                controller: controller,
                count: colors.length,
                effect: const ScrollingDotsEffect(
                    dotHeight: 12,
                    dotWidth: 12,
                    fixedCenter: true,
                    activeDotColor: Colors.deepOrange,
                    activeDotScale: 1.5),
              ),
              const SizedBox(height: 10),
              SmoothPageIndicator(
                controller: controller,
                count: colors.length,
                effect: const SwapEffect(
                  dotHeight: 12,
                  dotWidth: 12,
                  activeDotColor: Colors.deepOrange,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
