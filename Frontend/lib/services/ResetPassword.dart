 import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:ai_trip_planner/components/ErrorAlert.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
 
 FirebaseAuth _auth = FirebaseAuth.instance;


 void sendEmailToExistingUser(context, email) async {
    try {
      if (email != null) {
        var emailmethod = await _auth.fetchSignInMethodsForEmail( email);

        for (var method in emailmethod) {
          if (method == 'password') {
            await _auth.sendPasswordResetEmail(email: email).then((fun) {
              print('email send');
            });

            await Alert(
                    context: context,
                    title: 'SUCCESS',
                    content: Text(
                        'An email has been sent to your email address to reset your password'))
                .show();
          } else {
            Alert(
                    context: context,
                    title: 'ALERT',
                    content: Text(
                        'Please provide the E-Mail address that you used for sign up'))
                .show();
          }
        }
      } else {
        Alert(
                context: context,
                title: 'ALERT',
                content: Text(
                    'Please provide the E-Mail address that you used for sign up'))
            .show();
      }
    } catch (e) {
      Alert(
              context: context,
              title: 'ALERT',
              content: Text(
                  'Please provide the E-Mail address that you used for sign up'))
          .show();
    }
  }