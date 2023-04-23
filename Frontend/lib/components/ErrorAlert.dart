import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void error(BuildContext context, String errormessage) {
  Alert(
    context: context,
    title: "ERROR",
    content: Text(errormessage),
    buttons: [
      DialogButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text(
          "OK",
          style: TextStyle(color: Colors.black, fontSize: 20),
        ),
      ),
    ],
  ).show();
}