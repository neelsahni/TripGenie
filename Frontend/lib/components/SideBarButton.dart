import 'package:flutter/material.dart';
import 'package:ai_trip_planner/constants.dart';

class Sidebar_item extends StatelessWidget {
  final String? label;
  Function? onPressed;

  Sidebar_item({this.label, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(7),
      child: Container(
        decoration: kButtonDecoration,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: MaterialButton(
            onPressed: onPressed as void Function()?,
            child: Text(
              label!,
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
