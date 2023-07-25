import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_packages/widgets/button_file.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoPackages extends StatefulWidget {
  const InfoPackages({Key? key}) : super(key: key);

  @override
  State<InfoPackages> createState() => _InfoPackagesState();
}

class _InfoPackagesState extends State<InfoPackages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Info Packages"),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ButtonFile(
                btnText: "Device Info",
                btnTap: () async {
                  DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
                  if (Platform.isAndroid) {
                    AndroidDeviceInfo info = await deviceInfoPlugin.androidInfo;
                    log(info.model);
                    log(info.brand);
                    log(info.product);
                    log(info.manufacturer);
                    log("${info.version}");
                  } else if (Platform.isIOS) {
                    IosDeviceInfo info = await deviceInfoPlugin.iosInfo;
                    log("${info.systemName}");
                  }
                },
              ),
              ButtonFile(
                btnText: "Package Info",
                btnTap: () async {
                  PackageInfo packageInfo = await PackageInfo.fromPlatform();
                  log(packageInfo.appName);
                  log(packageInfo.packageName);
                  log(packageInfo.version);
                  log(packageInfo.buildNumber);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
