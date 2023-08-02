import 'package:flutter/material.dart';

class HelperContainer extends StatelessWidget {
  final Color colors;
  final String text;

  const HelperContainer({Key? key, required this.colors, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: colors,
        ),
        child: Center(
            child: Text(
          text,
          style: const TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
