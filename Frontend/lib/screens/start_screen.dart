import 'dart:io' show Platform, stdout;
//import 'package:ai_trip_planner/screens/IntroSlider.dart';
import 'package:ai_trip_planner/screens/Login.dart';
import 'package:ai_trip_planner/screens/SignupQuestions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ai_trip_planner/screens/mainpage.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter/services.dart';
import 'package:ai_trip_planner/services/AppleSignin.dart';
import 'package:ai_trip_planner/components/ErrorAlert.dart';
import 'package:ai_trip_planner/services/GoogleSignIn.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

//TODO: cleanup like mainpage

final _auth = FirebaseAuth.instance;

final _firestore = FirebaseFirestore.instance;

User? loggedinUser;

Future<void>? _fetchdata;

class Startpagecontent extends StatefulWidget {
  @override
  _StartpagecontentState createState() => _StartpagecontentState();
}

class _StartpagecontentState extends State<Startpagecontent> {
  Future<User?> getUser() async {
    return await _auth.currentUser;
  }

  @override
  void initState() {
    super.initState();

    _fetchdata = getCurrentUser();
  }

  //This is for getting the current user
  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MainPage(), fullscreenDialog: true));
      }
    } catch (e) {
      print(e);
    }
  }

  String? email;
  String? password;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return Scaffold(
      body: Container(
        constraints: BoxConstraints(
            maxHeight: double.infinity, maxWidth: double.infinity),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                // Padding(
                //   padding: const EdgeInsets.all(2.0),
                //   child: Container(
                //     child: Hero(
                //       tag: 'logo',
                //       child: Image.asset(
                //         'assets/logo.png',
                //         fit: BoxFit.fill,
                //         scale: MediaQuery.of(context).orientation ==
                //                 Orientation.landscape
                //             ? 0.7
                //             : 0.4,
                //       ),
                //     ),
                //   ),
                // ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Padding(
                        padding: EdgeInsets.all(1.0),
                        child: Text(
                          'SIGN UP',
                          style: TextStyle(
                              fontSize: 40, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Text(
                        'The start is a piece of cake',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // FutureBuilder(builder: (context, snapshot) {
                          //   if (Platform.isIOS) {
                          //     return
                          Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: SignInButton(Buttons.GoogleDark,
                                  text: 'Sign in with Google',
                                  onPressed: () async {
                                try {
                                  //TODO: fix this for android
                                  await signInWithGoogle().whenComplete(() {
                                    try {
                                      // checks version of app
                                      getUser().then((user) {
                                        _firestore
                                            .collection('users')
                                            .doc(user!.uid)
                                            .set({'version': '0.1'});
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Questions(),
                                              fullscreenDialog: true),
                                        );
                                      });
                                    } catch (e) {
                                      // TODO: handle error
                                      error(context,
                                          'Sign in did not work, please try again later');
                                    }
                                  });
                                } catch (e) {}
                              })),
                          // } else {
                          //   return Container();
                          // }
                          // }),
                          FutureBuilder(
                            builder: (context, snapshot) {
                              if (Platform.isIOS) {
                                return Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: SignInButton(
                                    Buttons.AppleDark,
                                    text: 'Sign in with Apple',
                                    onPressed: () async {
                                      await signInWithApple();
                                      if (_auth.currentUser != null) {
                                        getUser().then((user) {
                                          _firestore
                                              .collection('users')
                                              .doc(user!.uid)
                                              .set({'version': '0.1'});
                                          if (user != null) {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Questions(),
                                                    fullscreenDialog: true));
                                          }
                                        });
                                      } else {
                                        error(context,
                                            'Sign in did not work, please try again later');
                                      }
                                    },
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            },
                          ),
                          Padding(
                            padding: const EdgeInsets.all(1.0),
                            child: SignInButton(Buttons.Email,
                                text: 'Start with Email', onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Sign_in()));
                            }),
                            //sign in without any account
                            // Padding(
                            //   padding: const EdgeInsets.all(4.0),
                            //   child: GestureDetector(
                            //     child: Text('Continue without account'),
                            //     onTap: () {
                            //       Navigator.push(
                            //           context,
                            //           MaterialPageRoute(
                            //               builder: (context) => Main_page()));
                            //     },
                            //   ),
                            // ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
