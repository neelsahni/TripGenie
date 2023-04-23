import 'package:ai_trip_planner/components/ErrorAlert.dart';
import 'package:ai_trip_planner/components/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:ai_trip_planner/screens/IntroSlider.dart'; we can later implement a Intro slider
import 'package:ai_trip_planner/screens/mainpage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ai_trip_planner/services/ResetPassword.dart';
import 'package:ai_trip_planner/components/TextFieldLogin.dart';
import 'package:ai_trip_planner/components/LoginSignButton.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

final _auth = FirebaseAuth.instance;

final _firestore = FirebaseFirestore.instance;

String? email;
String? password;

User? loggedinUser;

// This is the sign in screen.
class Sign_in extends StatefulWidget {
  @override
  _Sign_inState createState() => _Sign_inState();
}

class _Sign_inState extends State<Sign_in> {
  Future<User?> getUser() async {
    return await _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();

    getUser().then((user) {
      if (user != null) {
        loggedinUser = user;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(), fullscreenDialog: true));
      }
    });
  }

  //TODO: Include error handling for logging in: https://firebase.flutter.dev/docs/auth/error-handling

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign in / Sign up'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // Center(
          //   heightFactor: 1.4,
          //   child: Container(
          //     child: Hero(
          //       tag: 'logo',
          //       child: Image.asset(
          //         'assets/logo.png',
          //         height: SizeConfig.screenHeight / 5.2,
          //         fit: BoxFit.fitWidth,
          //       ),
          //     ),
          //   ),
          // ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              TextFieldLogin(
                  label: 'email',
                  text: 'Enter E-Mail:',
                  obscuretext: false,
                  textinputtype: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  }),
              TextFieldLogin(
                label: 'password',
                text: 'Enter Password:',
                obscuretext: true,
                onChanged: (value) {
                  password = value;
                },
              ),
              SizedBox(height: 10),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginSigninButton(
                      label: 'Sign in',
                      onPressed: () async {
                        try {
                          if (email != null && password != null) {
                            UserCredential result =
                                await _auth.signInWithEmailAndPassword(
                                    email: email!, password: password!);
                            User? user = result.user;

                            if (user != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MainPage(),
                                      fullscreenDialog: true));
                            } else {
                              error(context,
                                  "Try using another Email or Password.");
                            }
                          } else {
                            error(context,
                                "Try using another Email or Password.");
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            error(context,
                                "Try using another Email or Password.");
                          } else if (e.code == 'wrong-password') {
                            error(context,
                                "Try using another Email or Password.");
                          }
                        }
                      },
                    ),
                    LoginSigninButton(
                      label: 'Sign up',
                      onPressed: () async {
                        try {
                          final newUser =
                              await _auth.createUserWithEmailAndPassword(
                                  email: email!, password: password!);
                          if (newUser != null) {
                            Navigator.pop(context);

                            getUser().then((user) {
                              _firestore
                                  .collection('users')
                                  .doc(user!.uid)
                                  .set({'version': '0.1'});
                              if (user != null) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      //TODO: change back to IntroScreen once implemented
                                        builder: (context) => MainPage(),
                                        fullscreenDialog: true));
                              }
                            });
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            error(
                                context, 'The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            error(context,
                                'The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                          error(
                              context, "Try using another Email or Password.");
                        }
                      },
                    ),
                  ],
                ),
              ),
              LoginSigninButton(
                label: 'Forgot Password',
                onPressed: () async {
                  try {
                    if (email != null) {
                      sendEmailToExistingUser(context, email);
                    } else {
                      error(context, "Please provide an email address first.");
                    }
                  } catch (e) {
                    error(context, "Try using another Email or Password.");
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
