//making submission string to submit to openai by getting user data from firestore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String name = "";
String age = "";
String job = "";
String home = "";

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;

String makeString(User loggedinUser, String description) {
  //get user data from firestore
  String userString = "";

  //get user data from firestore
  _firestore
      .collection('users')
      .doc(loggedinUser.uid)
      .get()
      .then((DocumentSnapshot documentSnapshot) {
    if (documentSnapshot.exists) {
      name = documentSnapshot.get('name');
      age = documentSnapshot.get('age');
      job = documentSnapshot.get('job');
      home = documentSnapshot.get('home');
    }
  });
//make string to submit to openai
  userString = "My name is " +
      name +
      ". I am " +
      age +
      " years old. I am a " +
      job +
      ". I live in " +
      home +
      ". " +
      "Help me book a trip. Here is what I am looking for: " +
      description;
  return userString;
}
