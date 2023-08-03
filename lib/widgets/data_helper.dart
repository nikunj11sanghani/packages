import 'package:flutter/material.dart';
import 'package:flutter_packages/model/employee.dart';

class DataHelper extends StatelessWidget {
  final Employee employee;
  final void Function() onTap;
  final void Function() onLongPress;

  const DataHelper({Key? key, required this.onTap, required this.employee, required this.onLongPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        color: Colors.lime,
        child: ListTile(
          onLongPress: onLongPress,
          onTap: onTap,
          leading: const CircleAvatar(
            child: Icon(Icons.person),
          ),
          title: Text("Name $employee.name"),
          subtitle: Text("ID $employee.id"),
        ),
      ),
    );
  }
}
