import 'package:ai_trip_planner/components/TextFieldAdd.dart';
import 'package:ai_trip_planner/screens/MainPage.dart';
import 'package:ai_trip_planner/services/verifyUser.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


String name = "";
String age = "";
String job = "";
String home = "";

final _auth = FirebaseAuth.instance;
final _firestore = FirebaseFirestore.instance;
late User loggedinUser;
Future<void>? _fetchdata;
int updatecheck = 0;
//to check if user is logged in
bool userExisting = false;


class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {

  @override
  void initState() {
    super.initState();
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
        title: Text('Questions'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextFieldAdd(
            text: "Name:",
            onchanged: (value) {
              name = value;
            }
          ), 
          TextFieldAdd(
            text: "Age:",
            onchanged: (value) {
              age = value;
            }
            ),
            TextFieldAdd(
            text: "Job:",
            onchanged: (value) {
              job = value;
            }
            ),
            TextFieldAdd(
            text: "Home:",
            onchanged: (value) {
              home = value;
            }
            ),
            TextButton(onPressed: () {
              print(name);
              print(age);
              print(job);
              print(home);


            _firestore.collection('users').doc(loggedinUser.uid).set({
              'name': name,
              'age': age,
              'job': job,
              'home': home,
            });

            Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
              
            }, child: Text("Submit")),

            Text("If you already filled out that info skip it here:"),

            TextButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
            }, child: Text("Skip"))
            
          
        ],
      ),
    );
  }
}