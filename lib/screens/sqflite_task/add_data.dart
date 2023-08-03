import 'package:flutter/material.dart';
import 'package:flutter_packages/db_manager.dart';
import 'package:flutter_packages/model/employee.dart';
import 'package:flutter_packages/widgets/button_file.dart';

class AddData extends StatefulWidget {
  final Employee? employee;

  const AddData({Key? key, this.employee}) : super(key: key);

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    if (widget.employee != null) {
      nameController.text = widget.employee!.name;
      ageController.text = widget.employee!.age.toString();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.employee == null ? "Add Data" : "Update Data"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Name";
                    }
                    return null;
                  },
                  controller: nameController,
                  decoration: const InputDecoration(
                      hintText: "Name",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Age";
                    }
                    return null;
                  },
                  controller: ageController,
                  decoration: const InputDecoration(
                      hintText: "Age",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)))),
                ),
                ButtonFile(
                  btnText: widget.employee == null ? "Add" : "Update",
                  btnTap: () async {
                    if (formKey.currentState!.validate()) {
                      final name = nameController.value.text;
                      final age = ageController.value.text;
                      if (name.isEmpty || age.isEmpty) {
                        return;
                      }
                      final Employee employee = Employee(
                          id: widget.employee!.id,
                          name: name,
                          age: int.parse(age));

                      if (widget.employee == null) {
                        await DBManager.addEmployee(employee);
                      } else {
                        await DBManager.updateEmployee(employee);
                      }
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
