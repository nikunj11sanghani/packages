import 'package:flutter/material.dart';

class ButtonFile extends StatelessWidget {
  final String btnText;
  final void Function() btnTap;

  const ButtonFile({Key? key, required this.btnText, required this.btnTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 250,
        child: ElevatedButton(onPressed: btnTap, child: Text(btnText)));
  }
}
