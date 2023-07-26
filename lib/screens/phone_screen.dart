import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_packages/screens/pin_code_screen.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({Key? key}) : super(key: key);

  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String currenntText = '';
  String id = '';

  @override
  void initState() {
    countryController.text = "+91";
    super.initState();
  }

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Phone Verification",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "We need to register your phone without getting started!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countryController,
                          keyboardType: TextInputType.phone,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Phone",
                        ),
                      ))
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance.verifyPhoneNumber(
                              phoneNumber:
                                  countryController.text + phoneController.text,
                              verificationCompleted: (phoneAuthCredential) {
                                if (phoneAuthCredential.smsCode != null) {
                                  setState(() {
                                    currenntText = phoneAuthCredential.smsCode!;
                                  });
                                }
                                log("sms${phoneAuthCredential.smsCode!}");
                              },
                              verificationFailed: (error) {
                                phoneController.clear();
                                snackBar(
                                    "Something Went Wrong Please Re-enter Mobile Number");
                                log("error${error.toString()}");
                              },
                              codeSent: (verificationId, forceResendingToken) {
                                setState(() {
                                  id = verificationId;
                                });
                                if (mounted) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => PinCodeScreen(
                                          currentText: currenntText,
                                          verificationId: id,
                                          phoneNumber: phoneController.text,
                                        ),
                                      ));
                                }
                              },
                              codeAutoRetrievalTimeout: (verificationId) {},
                            );
                          } catch (e) {
                            phoneController.clear();
                            snackBar(
                                "Something Went Wrong Please Re-enter Mobile Number");
                          }
                        }
                      },
                      child: const Text("Send the code")),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
