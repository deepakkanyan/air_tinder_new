import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/auth/complete_profile/completion_checker.dart';
import 'package:air_tinder/view/auth/login.dart';
import 'package:flutter/material.dart';

class SplashScreenProvider {
  void checkIfLoggedIn(BuildContext context) {
    if (auth.currentUser != null) {
      final String uID = auth.currentUser!.uid;
      Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => CompletionChecker(uID: uID)),
          (route) => false,
        ),
      );
    } else {
      Future.delayed(
        Duration(seconds: 2),
        () => Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => Login()), (route) => false),
      );
    }
  }
}
