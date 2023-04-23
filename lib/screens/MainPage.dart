import 'package:ai_trip_planner/components/TextFieldAdd.dart';
import 'package:flutter/material.dart';

//global variables

String name = "";


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            TextFieldAdd(
              text: "Name",
              onchanged: (name) {
                print(name);
              },
            )
          ],
        ),
      ),

    );
  }
}