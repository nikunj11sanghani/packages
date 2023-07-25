import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class IntlPackage extends StatefulWidget {
  const IntlPackage({Key? key}) : super(key: key);

  @override
  State<IntlPackage> createState() => _IntlPackageState();
}

class _IntlPackageState extends State<IntlPackage> {
  @override
  Widget build(BuildContext context) {
    initializeDateFormatting("es_US");
    DateTime dateTime = DateTime.now();
    String data1 = DateFormat.yMEd().format(dateTime);
    String data2 = DateFormat.yMMMd().format(dateTime);
    String data3 = DateFormat.yMEd().format(dateTime);
    String data4 = DateFormat("Hms", "es_US").format(dateTime);
    String data5 = DateFormat.yMEd().add_jms().format(dateTime);
    String continueMessage() => Intl.message('Hit any key to continue',
        // name: 'continueMessage',
        // args: [],
        desc: 'Explains that we will not proceed further until '
            'the user presses a key');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Intl Package"),
      ),
      body: Center(
        child: Column(
          children: [
            Text(data1),
            Text(data2),
            Text(data3),
            Text(data4),
            Text(data5),
            Text(continueMessage()),
          ],
        ),
      ),
    );
  }
}
