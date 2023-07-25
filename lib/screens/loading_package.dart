import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_packages/widgets/button_file.dart';

class LoadingCustom extends StatefulWidget {
  const LoadingCustom({Key? key}) : super(key: key);

  @override
  State<LoadingCustom> createState() => _LoadingCustomState();
}

class _LoadingCustomState extends State<LoadingCustom> {
  void progressBar() {
    EasyLoading.showProgress(0.5, status: "Loading");
    Future.delayed(
      const Duration(seconds: 3),
      () => EasyLoading.dismiss(),
    );
  }

  void showSuccess() {
    EasyLoading.showSuccess("Process Complete");
  }

  void infoMsg() {
    EasyLoading.showInfo("Info Message", maskType: EasyLoadingMaskType.black);
  }

  void error() {
    EasyLoading.showError("Error Message", maskType: EasyLoadingMaskType.black);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Loading Customs"),
      ),
      body: Center(
        child: Column(
          children: [
            ButtonFile(
              btnText: ".showProgress",
              btnTap: () {
                progressBar();
              },
            ),
            ButtonFile(
              btnText: ".showSuccess",
              btnTap: () {
                showSuccess();
              },
            ),
            ButtonFile(
              btnText: ".showInfo",
              btnTap: () {
                infoMsg();
              },
            ),
            ButtonFile(
              btnText: ".showError",
              btnTap: () {
                error();
              },
            ),
          ],
        ),
      ),
    );
  }
}
