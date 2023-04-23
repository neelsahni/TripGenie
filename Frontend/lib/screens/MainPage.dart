import 'package:ai_trip_planner/components/TextFieldAdd.dart';
import 'package:ai_trip_planner/screens/MyProfile.dart';
import 'package:ai_trip_planner/screens/start_screen.dart';
import 'package:ai_trip_planner/services/APIrequest.dart';
import 'package:ai_trip_planner/services/verifyUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


//global variables

String name = "";


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
              child: Text(
                'Menu',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                  color: Colors.blue,
                  // image: DecorationImage(
                  //     scale: 0.2,
                  //     alignment: Alignment.bottomRight,
                  //     //fit: BoxFit.scaleDown,

                  //     image: AssetImage('assets/logo.png'))),
              )
            ),
            userExisting? ListTile(
              leading: Icon(Icons.verified_user),
              title: Text('Profile'),
              onTap: () => {
                // myBanner.dispose(),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProfile()))
              },
            ): Container(),
            // userExisting? ListTile(
            //   leading: Icon(Icons.settings),
            //   title: Text('Settings'),
            //   onTap: () => {
            //     // myBanner.dispose(),
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => SettingsScreen(),
            //             fullscreenDialog: true))
            //   },
            // ) : Container(),
            
            //Explain section
            // ListTile(
            //   leading: Icon(Icons.help),
            //   title: Text('Explain'),
            //   onTap: () => {
            //     // myBanner.dispose(),
            //     Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => OnBoardingPage(),
            //             fullscreenDialog: true))
            //   },
            // ),
            userExisting? ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Log out'),
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
            ): Container(),
          ],
        ),
      ),
      
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFieldAdd(
              text: "Name",
              onchanged: (name) {
                print(name);
              },
            ),
            TextButton(
              child: Text("Test API"),
              
            onPressed: () async {
             String test = await (triggerCloudFunction("Hello"));
             print(test);

           },)
          ],
        ),
      ),

    );
  }
}