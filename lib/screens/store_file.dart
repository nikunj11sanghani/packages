import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_packages/routes.dart';
import 'package:flutter_packages/widgets/button_file.dart';
import 'package:flutter_packages/screens/image_store.dart';
import 'package:flutter_packages/screens/signin_screen.dart';
import 'package:flutter_packages/screens/stored_data.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class StoreFile extends StatefulWidget {
  const StoreFile({Key? key}) : super(key: key);

  @override
  State<StoreFile> createState() => _StoreFileState();
}

class _StoreFileState extends State<StoreFile> {
  File? image1;

  Future<void> takeImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imagePath = File(image.path);
      setState(() {
        image1 = imagePath;
      });
    } catch (e) {
      log("$e");
    }
  }

  Future<String> storeImage(File image) async {
    String url;
    String imgName = DateTime.now().microsecond.toString();
    Reference reference =
        FirebaseStorage.instance.ref().child("images").child("path$imgName");
    await reference.putFile(image);
    url = await reference.getDownloadURL();
    return url;
  }

  final CollectionReference demo =
      FirebaseFirestore.instance.collection("demo_user");

  //creating an instance for our table so that we can use it' property
  final formKey = GlobalKey<FormState>();

  final idController = TextEditingController();
  final addUserNameController = TextEditingController();
  final updateUserNameController = TextEditingController();

  Future<void> logInWithGoogle() async {
    GoogleSignInAccount? googleSignInAccount = await GoogleSignIn().signIn();
    // This prompts the user to sign in with their Google account using the Google Sign-In API.
    // Initializes global sign-in configuration settings.
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!
            .authentication; //If the sign-in process was successful, we retrieve the user's authentication credentials.
    AuthCredential credential = GoogleAuthProvider.credential(
      //create an AuthCredential object using the Google authentication tokens stored in googleSignInAuthentication.
      //AuthCredential= Interface that represents the credentials returned by an auth provider.
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );
    UserCredential userCredential = await FirebaseAuth
        .instance //entry point of the Firebase Authentication SDK
        .signInWithCredential(
            credential); //We sign in to Firebase using the Google credential created in the previous step, and store the result in userCredential.
    log(userCredential.user!.email.toString());
    log(userCredential.user!.displayName.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Fire Store Data"),
      ),
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return const SignInScreen();
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else {
              return Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding:
                          const EdgeInsets.only(right: 10, left: 10, top: 18.0),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(30),
                            child: image1 == null
                                ? const Text("You have not selected any Image")
                                : Image.file(
                                    height: 100,
                                    width: 200,
                                    image1!,
                                  ),
                          ),
                          TextButton(
                              onPressed: takeImage,
                              child: const Text("Select Image")),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Some Text";
                              }
                              return null;
                            },
                            controller: idController,
                            decoration: InputDecoration(
                                hintText: "Id",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Enter Some Text";
                              }
                              return null;
                            },
                            controller: addUserNameController,
                            decoration: InputDecoration(
                                hintText: "Username",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          ButtonFile(
                            btnText: "Login With Google",
                            btnTap: () {
                              logInWithGoogle();
                            },
                          ),
                          ButtonFile(
                            btnTap: () async {
                              final picUrl = await storeImage(image1!);
                              if (formKey.currentState!.validate() &&
                                  image1 != null) {
                                await demo.add({
                                  "Name": addUserNameController.text,
                                  "id": idController.text,
                                  "profile": picUrl,
                                }).whenComplete(() =>
                                    Fluttertoast.showToast(msg: "User Added"));
                                idController.clear();
                                addUserNameController.clear();
                                setState(() {
                                  image1 = null;
                                });
                                storeImage(image1!);
                              }
                            },
                            btnText: "Add User",
                          ),
                          ButtonFile(
                            btnTap: () async {
                              if (formKey.currentState!.validate() &&
                                  image1 != null) {
                                final picUrl = await storeImage(image1!);
                                await demo.doc("rmrGWABYczu9UsiTrEmi").update({
                                  "Name": addUserNameController.text,
                                  "id": idController.text,
                                  "profile": picUrl,
                                });
                                // addUserNameController.clear();
                              }
                            },
                            btnText: 'Update User',
                          ),
                          ButtonFile(
                            btnTap: () async {
                              await demo.doc("CibRPPxSpVhz86StzJ4A").delete();
                            },
                            btnText: 'Delete Button',
                          ),
                          ButtonFile(
                            btnTap: () {
                              Navigator.pushNamed(
                                  context,Routes.storedData);
                            },
                            btnText: 'Show Data',
                          ),
                          ButtonFile(
                            btnTap: () {
                              Navigator.pushNamed(
                                  context,Routes.imageStore);
                            },
                            btnText: 'Add Image',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
  }
}
