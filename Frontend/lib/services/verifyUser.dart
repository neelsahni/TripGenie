 //TODO: think about phone authentication
  import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ai_trip_planner/components/ErrorAlert.dart';


final _auth = FirebaseAuth.instance;

Future<void> verifyUser(User loggedinUser, context) async {
    if (!loggedinUser.emailVerified) {
      await loggedinUser.sendEmailVerification();
      //TODO: maybe include button to get to mail program

      await _auth.signOut();

      // Navigator.push(
      //     context,
    //       MaterialPageRoute(
    //           builder: (context) => Sign_in(), fullscreenDialog: true));
    //   error(context,
    //       "Please verify your email address. We've sent you an email!");
     //}
  };
}