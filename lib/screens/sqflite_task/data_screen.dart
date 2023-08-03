import 'package:flutter/material.dart';
import 'package:flutter_packages/db_manager.dart';
import 'package:flutter_packages/screens/sqflite_task/add_data.dart';
import 'package:flutter_packages/widgets/button_file.dart';
import 'package:flutter_packages/widgets/data_helper.dart';

class DataScreen extends StatefulWidget {
  const DataScreen({Key? key}) : super(key: key);

  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Data"),
      ),
      body: Center(
        child: FutureBuilder(
          future: DBManager.getAllData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else if (snapshot.hasData) {
              if (snapshot.data != null) {
                ListView.builder(
                  itemBuilder: (context, index) {
                    return DataHelper(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddData(employee: snapshot.data![index])));
                        setState(() {});
                      },
                      employee: snapshot.data![index],
                      onLongPress: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text(
                                  "Are you sure you want to delete this employee"),
                              actions: [
                                ButtonFile(
                                  btnText: "Yes",
                                  btnTap: () async {
                                    await DBManager.deleteEmployee(
                                            snapshot.data![index])
                                        .then(
                                            (value) => Navigator.pop(context));
                                    setState(() {});
                                  },
                                ),
                                ButtonFile(
                                  btnText: "No",
                                  btnTap: () {
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                    );
                  },
                );
              }
            }
            return const Text("No Records Found");
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddData(),
              ));
          setState(() {});
        },
        //
        // onPressed: () {
        //   Navigator.pushNamed(context, Routes.addData);
        // },
        child: const Center(child: Icon(Icons.add)),
      ),
    );
  }
}
