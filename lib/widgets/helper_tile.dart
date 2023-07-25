import 'package:flutter/material.dart';

class HelperTile extends StatelessWidget {
  final String leading, title,id;

  const HelperTile(
      {super.key,
      required this.leading,
      required this.title,
      required this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.deepPurple[100],
        child: Text(
          textAlign: TextAlign.center,
          leading,
          style: const TextStyle(
              fontWeight: FontWeight.bold, color: Colors.black, fontSize: 20),
        ),
      ),
      title: Text(title),
      subtitle: Text(id),
    );
  }
}
