import 'package:ai_trip_planner/components/TextFieldAdd.dart';
import 'package:ai_trip_planner/screens/MyProfile.dart';
import 'package:ai_trip_planner/screens/Results.dart';
import 'package:ai_trip_planner/screens/start_screen.dart';
import 'package:ai_trip_planner/services/APIrequest.dart';
import 'package:ai_trip_planner/services/makeString.dart';
import 'package:ai_trip_planner/services/verifyUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

//global variables

String description = "";

//init Firebase
final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
late User loggedinUser;
Future<void>? _fetchdata;
int updatecheck = 0;
//to check if user is logged in
bool userExisting = false;

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    // _initGoogleMobileAds();
    //TODO: figure out better way to do this
    // myBanner.load().onError((error, stackTrace) {
    //   print(error);
    //   setState(() {
    //     workingAd = false;
    //   });
    // });
    // _loadRewardedAd();
    getCurrentUser();
  }

  //TODO: maybe refactor since more than one using
  Future<void> getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        userExisting = true;
        loggedinUser = user;
        verifyUser(loggedinUser, context);
      } else {
        userExisting = false;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Trip Genie"),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                )),
            ListTile(
              leading: const Icon(Icons.verified_user),
              title: const Text(
                'Profile',
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
              onTap: () => {
                // myBanner.dispose(),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfile()))
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log out',
                  style: TextStyle(fontSize: 20, color: Colors.black)),
              onTap: () async {
                //waiting to sign out the user before proceeding to Start screen
                await _auth.signOut();
                // myBanner.dispose();
                userExisting = false;

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Startpagecontent(),
                        fullscreenDialog: true));
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFieldAdd(
              text: "Short Discription of your trip:",
              onchanged: (des) {
                description = des;
              },
            ),
            TextButton(
              child: Text("Submit"),
              onPressed: () async {
                String result = await (triggerCloudFunction(
                    makeString(loggedinUser, description)));
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Results(result: result)));
              },
            )
          ],
        ),
      ),
    );
  }
}
