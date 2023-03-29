import 'package:flutter/material.dart';
import 'package:flutter_packages/button_file.dart';
import 'package:url_launcher/url_launcher.dart';

class LaunchUrl extends StatefulWidget {
  const LaunchUrl({Key? key}) : super(key: key);

  @override
  State<LaunchUrl> createState() => _LaunchUrlState();
}

class _LaunchUrlState extends State<LaunchUrl> {
  Future<void> urlLaunch() async {
    const url = "https://maps.google.com";
    final finalUrl = Uri.parse(url);
    if (await canLaunchUrl(
      finalUrl,
    )) {
      await launchUrl(finalUrl);
    }
  }

  Future<void> makeCall() async {
    const mobileNo = "+919925320820";
    const lastUrl = 'tel:$mobileNo';
    final finalUrl = Uri.parse(lastUrl);

    if (await canLaunchUrl(
      finalUrl,
    )) {
      await launchUrl(finalUrl);
    }
  }

  Future<void> sendMsg() async {
    const mobileNo = "+919328646220";
    const lastUrl = 'sms:$mobileNo';
    final finalUrl = Uri.parse(lastUrl);

    if (await canLaunchUrl(
      finalUrl,
    )) {
      await launchUrl(finalUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Url Launcher Package"),
      ),
      body: Center(
        child: Column(
          children: [
            ButtonFile(
              btnText: 'Launch Url',
              btnTap: urlLaunch,
            ),
            ButtonFile(
              btnText: 'Make a call',
              btnTap: makeCall,
            ),
            ButtonFile(
              btnText: 'Send a message',
              btnTap: sendMsg,
            ),
          ],
        ),
      ),
    );
  }
}
