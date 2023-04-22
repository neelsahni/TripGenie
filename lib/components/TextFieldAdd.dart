import 'package:flutter/material.dart';
import 'package:ai_trip_planner/constants.dart';

class TextFieldAdd extends StatelessWidget {
  const TextFieldAdd({this.text, this.controlling, this.onchanged});

  final String? text;
  final TextEditingController? controlling;
  final Function? onchanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onchanged as void Function(String)?,
      controller: controlling,
      style: TextStyle(color: Colors.blue, ),
      decoration: kTextFieldAddDecoration.copyWith(labelText: text),
    );
  }
}
