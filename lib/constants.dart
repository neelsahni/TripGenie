import 'package:flutter/material.dart';

const kTextFieldAddDecoration = InputDecoration(
  enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(width: 1, color: Colors.blue),
  ),
  disabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(width: 1, color: Colors.blue),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    borderSide: BorderSide(width: 1, color: Colors.blue),
  ),
  labelText: 'text',
  labelStyle: TextStyle(color: Colors.grey),
  border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue),
    borderRadius: BorderRadius.all(
      Radius.circular(20),
    ),
  ),
);

var kButtonDecoration =
    BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.blue);

const kIntroSliderHeadersTextStyle = TextStyle(
  color: Colors.blue,
  fontSize: 25.0,
  fontWeight: FontWeight.bold,
  // fontFamily: 'RobotoMono'
);

const kIntroSliderDescriptionTextStyle = TextStyle(
  color: Colors.white,
  fontSize: 16.0,
  fontStyle: FontStyle.italic,
  // fontFamily: 'Raleway'
);

const kUpdateItemPopupDecoration = InputDecoration(
    enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.blue)),
    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue),
    ),
    labelText: 'Item',
    hintStyle: TextStyle(color: Colors.blue));

//locallizing if either imperial (false) or metric (true)
bool system = false;

bool ColorNaming = true;

//compression quality
int quality = 10;
