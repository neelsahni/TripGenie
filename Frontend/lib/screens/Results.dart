import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

//make class that takes in string called result and displays it
class Results extends StatefulWidget {
  const Results({required this.result});

  final String result;

  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Your Trip'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          widget.result,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
      ),
    ));
  }
}
