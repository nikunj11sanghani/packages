import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  Future<void> logOut() async {
    GoogleSignIn googleSignInAccount = GoogleSignIn();
    await googleSignInAccount
        .disconnect(); //Disconnects the current user from the app and revokes previous authentication
    FirebaseAuth.instance.signOut(); //signOut the current user
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              logOut();
            },
            child: const Text("Logout")),
      ),
    );
  }
}
