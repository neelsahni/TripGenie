import 'package:flutter/material.dart';
import 'package:ai_trip_planner/constants.dart';

class LoginSigninButton extends StatelessWidget {
  LoginSigninButton({this.label, this.onPressed});

  final label;
  Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: kButtonDecoration,
        child: MaterialButton(
          onPressed: onPressed as void Function()?,
          child: Text(label),
        ),
      ),
    );
  }
}
