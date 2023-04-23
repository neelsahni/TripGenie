import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:ai_trip_planner/screens/start_screen.dart';
import 'package:ai_trip_planner/components/ErrorAlert.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:ai_trip_planner/services/AppleSignin.dart';
import 'package:ai_trip_planner/services/GoogleSignIn.dart';
import 'package:ai_trip_planner/services/ResetPassword.dart';
import '../services/AppleSignin.dart';
import '../services/GoogleSignIn.dart';

//TODO: figure out how to delete all data from user once user deletes account

final _firestore = FirebaseFirestore.instance;
late User loggedinUser;

Future<void>? _fetchdata;

String? itemUpdate;

late String emailToDelete;
late String passwordToDelete;

String? mail = '';

FirebaseAuth _auth = FirebaseAuth.instance;

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  void initState() {
    super.initState();

    _fetchdata = getCurrentUser();
  }

  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
        mail = loggedinUser.email;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Profile')),
      body: FutureBuilder(
        future: _fetchdata,
        builder: (context, myFuture) {
          if (myFuture.connectionState == ConnectionState.done &&
              !myFuture.hasError) {
            return SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                   Padding(
          padding: const EdgeInsets.all(30.0),
          child: getProfileImage(),
        ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue,
                        ),
                        height: 50,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FittedBox(
                            child: Text(
                              '  E-Mail: $mail',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: MaterialButton(
                          child: Text('Reset Password',
                              style: TextStyle(color: Colors.white)),
                          onPressed: () async {
                            sendEmailToExistingUser(
                                context, loggedinUser.email);
                          }),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.blue,
                      ),
                      child: MaterialButton(
                        child: Text('Delete Account',
                            style: TextStyle(color: Colors.white)),
                        onPressed: () {
                          Alert(
                            context: context,
                            title: "Delete Account",
                            content: Column(
                              children: <Widget>[
                                Text(
                                    'To delete your account you need to sign in again with the account you used for signing in in the first place'),
                                TextField(
                                  onChanged: (value) {
                                    emailToDelete = value;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                  ),
                                ),
                                TextField(
                                  onChanged: (value) {
                                    passwordToDelete = value;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                  ),
                                ),
                                SignInButton(
                                  Buttons.GoogleDark,
                                  onPressed: () async {
                                    var emailmethod =
                                        await _auth.fetchSignInMethodsForEmail(
                                            loggedinUser.email!);

                                    for (var method in emailmethod) {
                                      if (method == "password") {
                                        error(context,
                                            "You used sign in with email, therefore you can't delete your account with Google");
                                      } else {
                                        try {
                                          await signInWithGoogle();
                                          await _firestore
                                              .collection('users')
                                              .doc(loggedinUser.uid)
                                              .delete();
                                          await loggedinUser.delete();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Startpagecontent(),
                                                fullscreenDialog: true),
                                          );
                                        } catch (e) {
                                          error(context,
                                              'Please sign in with your Account');
                                        }
                                      }
                                    }
                                  },
                                ),
                                SignInButton(
                                  Buttons.AppleDark,
                                  onPressed: () async {
                                    var emailmethod =
                                        await _auth.fetchSignInMethodsForEmail(
                                            loggedinUser.email!);

                                    for (var method in emailmethod) {
                                      if (method == "password") {
                                        error(context,
                                            "You used sign in with email, therefore you can't delete your account with Apple");
                                      } else {
                                        try {
                                          // TODO
                                          await signInWithApple();
                                          await _firestore
                                              .collection('users')
                                              .doc(loggedinUser.uid)
                                              .delete();
                                          await loggedinUser.delete();
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Startpagecontent(),
                                                fullscreenDialog: true),
                                          );
                                        } catch (e) {
                                          error(context,
                                              'Please sign in with your Account');
                                        }
                                        
                                      }
                                      
                                    }
                                  },
                                ),
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                color: Colors.blue,
                                onPressed: () async {
                                  try {
                                    await _auth.signInWithEmailAndPassword(
                                        email: emailToDelete,
                                        password: passwordToDelete);
                                    await _firestore
                                        .collection('users')
                                        .doc(loggedinUser.uid)
                                        .delete();
                                    await loggedinUser.delete();
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Startpagecontent(),
                                          fullscreenDialog: true),
                                    );
                                  } catch (e) {
                                    error(context,
                                        'Please sign in with your Account');
                                  }
                                },
                                child: Text(
                                  "Submit",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              DialogButton(
                                  color: Colors.blue,
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  })
                            ],
                          ).show();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Center(child: CupertinoActivityIndicator());
          }
        },
      ),
    );
  }
}
