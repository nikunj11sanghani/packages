import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeScreen extends StatefulWidget {
  PinCodeScreen({
    Key? key,
    this.phoneNumber,
    required this.currentText,
    required this.verificationId,
  }) : super(key: key);

  final String? phoneNumber;
  String currentText;
  final String verificationId;

  @override
  State<PinCodeScreen> createState() => _PinCodeScreenState();
}

class _PinCodeScreenState extends State<PinCodeScreen> {
  TextEditingController textEditingController = TextEditingController();

  StreamController<ErrorAnimationType>? errorController;

  bool hasError = false;
  TextEditingController countryController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  String currenntText = '';
  String id = '';

  @override
  void initState() {
    errorController = StreamController<ErrorAnimationType>();
    super.initState();
  }

  @override
  void dispose() {
    errorController!.close();
    super.dispose();
  }

  // snackBar Widget
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 8),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Phone Number Verification',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 8),
              child: RichText(
                text: TextSpan(
                  text: "Enter the code sent to ",
                  children: [
                    TextSpan(
                      text: "${widget.phoneNumber}",
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 30,
                ),
                child: PinCodeTextField(
                  appContext: context,
                  pastedTextStyle: TextStyle(
                    color: Colors.green.shade600,
                    fontWeight: FontWeight.bold,
                  ),
                  length: 6,
                  obscureText: true,
                  obscuringCharacter: '*',
                  blinkWhenObscuring: true,
                  animationType: AnimationType.scale,
                  validator: (v) {
                    if (v!.length < 3) {
                      return "I'm from validator";
                    } else {
                      return null;
                    }
                  },
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                  ),
                  cursorColor: Colors.black,
                  animationDuration: const Duration(milliseconds: 150),
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  keyboardType: TextInputType.number,
                  boxShadows: const [
                    BoxShadow(
                      offset: Offset(0, 1),
                      color: Colors.black12,
                      blurRadius: 10,
                    )
                  ],
                  onCompleted: (v) {
                    debugPrint("Completed");
                  },
                  // onTap: () {
                  //   print("Pressed");
                  // },
                  onChanged: (value) {
                    debugPrint(value);
                    // setState(() {
                    widget.currentText = value;
                    // });
                  },
                  beforeTextPaste: (text) {
                    debugPrint("Allowing to paste $text");
                    //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                    //but you can show anything you want here, like your pop up saying wrong paste format or etc
                    return true;
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Text(
                hasError ? "*Please fill up all the cells properly" : "",
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // TextButton(
            //   onPressed: () {
            //     AlertDialog(
            //       actions: [
            //         Form(
            //           key: formKey1,
            //           child: Column(
            //             children: [
            //               Container(
            //                 height: 55,
            //                 decoration: BoxDecoration(
            //                     border:
            //                         Border.all(width: 1, color: Colors.grey),
            //                     borderRadius: BorderRadius.circular(10)),
            //                 child: Row(
            //                   mainAxisAlignment: MainAxisAlignment.center,
            //                   children: [
            //                     const SizedBox(
            //                       width: 10,
            //                     ),
            //                     SizedBox(
            //                       width: 40,
            //                       child: TextField(
            //                         controller: countryController,
            //                         keyboardType: TextInputType.phone,
            //                         decoration: const InputDecoration(
            //                           border: InputBorder.none,
            //                         ),
            //                       ),
            //                     ),
            //                     const Text(
            //                       "|",
            //                       style: TextStyle(
            //                           fontSize: 33, color: Colors.grey),
            //                     ),
            //                     const SizedBox(
            //                       width: 10,
            //                     ),
            //                     Expanded(
            //                         child: TextField(
            //                       controller: phoneController,
            //                       keyboardType: TextInputType.phone,
            //                       decoration: const InputDecoration(
            //                         border: InputBorder.none,
            //                         hintText: "Phone",
            //                       ),
            //                     ))
            //                   ],
            //                 ),
            //               ),
            //               const SizedBox(
            //                 height: 20,
            //               ),
            //               SizedBox(
            //                 width: double.infinity,
            //                 height: 45,
            //                 child: ElevatedButton(
            //                     style: ElevatedButton.styleFrom(
            //                         shape: RoundedRectangleBorder(
            //                             borderRadius:
            //                                 BorderRadius.circular(10))),
            //                     onPressed: () async {
            //                       if (formKey1.currentState!.validate()) {
            //                         await FirebaseAuth.instance
            //                             .verifyPhoneNumber(
            //                           phoneNumber: countryController.text +
            //                               phoneController.text,
            //                           verificationCompleted:
            //                               (phoneAuthCredential) {
            //                             if (phoneAuthCredential.smsCode !=
            //                                 null) {
            //                               setState(() {
            //                                 currenntText =
            //                                     phoneAuthCredential.smsCode!;
            //                               });
            //                             }
            //                             log("sms${phoneAuthCredential.smsCode!}");
            //                           },
            //                           verificationFailed: (error) {
            //                             log("error${error.toString()}");
            //                           },
            //                           codeSent: (verificationId,
            //                               forceResendingToken) {
            //                             setState(() {
            //                               id = verificationId;
            //                             });
            //                             if (mounted) {
            //                               Navigator.push(
            //                                   context,
            //                                   MaterialPageRoute(
            //                                     builder: (context) =>
            //                                         PinCodeScreen(
            //                                       currentText: currenntText,
            //                                       verificationId: id,
            //                                       phoneNumber:
            //                                           phoneController.text,
            //                                     ),
            //                                   ));
            //                             }
            //                           },
            //                           codeAutoRetrievalTimeout:
            //                               (verificationId) {},
            //                         );
            //                       }
            //                     },
            //                     child: const Text("Send the code")),
            //               )
            //             ],
            //           ),
            //         )
            //       ],
            //     );
            //   },
            //   child: const Text(
            //     "RESEND OTP",
            //     style: TextStyle(
            //       color: Color(0xFF91D3B3),
            //       fontWeight: FontWeight.bold,
            //       fontSize: 16,
            //     ),
            //   ),
            // ),
            const SizedBox(height: 5),
            const SizedBox(
              height: 14,
            ),
            Container(
              margin:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 30),
              decoration: BoxDecoration(
                  color: Colors.green.shade300,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.green.shade200,
                        offset: const Offset(1, -2),
                        blurRadius: 5),
                    BoxShadow(
                        color: Colors.green.shade200,
                        offset: const Offset(-1, 2),
                        blurRadius: 5)
                  ]),
              child: ButtonTheme(
                height: 50,
                child: TextButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verificationId,
                                smsCode: widget.currentText);
                        await FirebaseAuth.instance
                            .signInWithCredential(credential);
                        snackBar("Login Succesfully");
                      } catch (e) {
                        log(e.toString());
                      }
                    }

                    // conditions for validating
                    // if (currentText.length != 6 || currentText != "123456") {
                    //   errorController!.add(ErrorAnimationType
                    //       .shake); // Triggering error shake animation
                    //   setState(() => hasError = true);
                    // } else {
                    //   setState(
                    //     () {
                    //       hasError = false;
                    //       snackBar("OTP Verified!!");
                    //     },
                    //   );
                    // }
                  },
                  child: Center(
                    child: Text(
                      "VERIFY".toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Flexible(
                  child: TextButton(
                    child: const Text("Clear"),
                    onPressed: () {
                      textEditingController.clear();
                    },
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
