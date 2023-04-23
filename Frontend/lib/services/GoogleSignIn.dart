import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _auth = FirebaseAuth.instance;

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth =
      await googleUser!.authentication;

  // Create a new credential
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await FirebaseAuth.instance.signInWithCredential(credential);
}

var src = _auth.currentUser!.photoURL;

//make round image for profile picture
getProfileImage() {
  if (_auth.currentUser!.photoURL != null) {
    return CircleAvatar(
      radius: 100,
      backgroundImage: NetworkImage(src.toString()),
    );
  } else {
    return CircleAvatar( radius: 100, child: Icon(Icons.account_circle, size: 100));
  }
}
