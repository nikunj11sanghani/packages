import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLaunch extends StatefulWidget {
  const UrlLaunch({Key? key}) : super(key: key);

  @override
  State<UrlLaunch> createState() => _UrlLaunchState();
}

class _UrlLaunchState extends State<UrlLaunch> {
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
            ElevatedButton(
                onPressed: urlLaunch, child: const Text("Launch Url")),
            ElevatedButton(
                onPressed: makeCall, child: const Text("Make a call")),
            ElevatedButton(
                onPressed: sendMsg, child: const Text("Send a message")),
          ],
        ),
      ),
    );
  }
}
