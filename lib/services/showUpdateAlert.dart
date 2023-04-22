// this is for the update alert
  import 'package:flutter/material.dart';
// import 'package:paintcalc/screens/mainpage.dart';
import 'package:path/path.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void showupdateAlert(BuildContext context) {
    Alert(
      context: context,
      title: "Please update the App",
      content: Column(
        children: <Widget>[
          Text(
              'There is a newer version for this app. For bug free usage please update!')
        ],
      ),
      buttons: [
        DialogButton(
          color: Colors.blue,
          child: Text('OK'),
          onPressed: () {
          //   Navigator.pop(context);
          //   Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //           builder: (context) => Main_page(), fullscreenDialog: true));
         },
        )
      ],
    ).show();
  }