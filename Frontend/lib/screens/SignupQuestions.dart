import 'package:ai_trip_planner/components/TextFieldAdd.dart';
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


class Questions extends StatefulWidget {
  const Questions({super.key});

  @override
  State<Questions> createState() => _QuestionsState();
}

class _QuestionsState extends State<Questions> {
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

              
            }, child: Text("Submit")),
            
          
        ],
      ),
    );
  }
}