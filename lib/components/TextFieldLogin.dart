import 'package:flutter/material.dart';
import 'package:ai_trip_planner/constants.dart';

class TextFieldLogin extends StatelessWidget {
  TextFieldLogin(
      {this.label,
      this.text,
      this.obscuretext,
      this.textinputtype,
      this.onChanged});

  var label;
  final text;
  final bool? obscuretext;
  final TextInputType? textinputtype;
  Function? onChanged;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Container(
          width: 300,
          child: Material(
            borderRadius: BorderRadius.circular(10),
            child: TextField(
              obscureText: obscuretext!,
              keyboardType: textinputtype,
              onChanged: onChanged as void Function(String)?,
              style: TextStyle(color: Colors.blue),
              decoration: kTextFieldAddDecoration.copyWith(labelText: text)
            ),
          ),
        ),
      ),
    );
  }
}
