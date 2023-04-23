import 'package:ai_trip_planner/home_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'components/theme.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _navigatorKey = GlobalKey<NavigatorState>();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError || snapshot == null) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return MaterialApp(

                navigatorKey: _navigatorKey,
                debugShowCheckedModeBanner: false,
                title: 'AI TRIP PLANNER',
                home: const MyHomePage(title: 'Airbnb Flutter Clone Project'),
             
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
