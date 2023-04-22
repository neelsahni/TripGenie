import 'package:ai_trip_planner/screens/WelcomeScreen.dart';
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
    return ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      
      child: Consumer<ThemeNotifier>(
        builder: (context, ThemeNotifier notifier, child) {

        return FutureBuilder(
            future: Firebase.initializeApp(),
            builder: (context, snapshot) {
              // Check for errors
              if (snapshot.hasError || snapshot == null) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                return MaterialApp(
                    localizationsDelegates: [
                      GlobalMaterialLocalizations.delegate,
                      GlobalWidgetsLocalizations.delegate,
                      GlobalCupertinoLocalizations.delegate,
                    ],
                    supportedLocales: [
                      const Locale('en', 'US'),
                      const Locale('es', 'ES'),
                      const Locale('de', 'DE'),
                    ],
                    theme: notifier.darkMode ? dark_mode : light_mode,
                    navigatorKey: _navigatorKey,
                    debugShowCheckedModeBanner: false,
                    title: 'Welcome to the Growth Planner',
                    //home: WelcomeScreenWidget(),
                    builder: (context, child) {
                      return MediaQuery(
                        child: child!,
                        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                      );
                    },
                    //TODO: start using everywhere...
                    initialRoute: 'Welcome',
                    
                 
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            });

      },


      ),
    );
  }
}
