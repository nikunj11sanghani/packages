import 'package:auto_size_text/auto_size_text.dart';
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
              child: Text("$count", key: ValueKey(count)),
            ),
            OutlinedButton(
                onPressed: () {
                  setState(() {
                    count += 1;
                  });
                },
                child: const Text("Switcher")),
            const AutoSizeText(
              "Because Row and other widgets like Container,"
              " Column or ListView do not constrain their children,"
              " the text will overflowYou can fix this by constraining the AutoSizeText."
              " Wrap it with Expanded in case of Row and Column or use a SizedBox or another "
              "widget with fixed width (and height).",
              maxLines: 2,
              minFontSize: 10,
              style: TextStyle(fontSize: 20),
              overflow: TextOverflow.ellipsis,
              overflowReplacement: Text("Not Suitable"),
              //overflowReplacement what displayed if it has overflow issue
              stepGranularity: 5,
              //stepGranularity means if over flow happens then it's next font size decrease by 5 like
              presetFontSizes: [20, 35, 30],
              // presetFontSizes means if over flow happens then it will first got 40 next one is 35 and after this 30
              //and if it is given then all font sizes are ignored
            )
          ],
        ),
      ),
    );
  }
}
