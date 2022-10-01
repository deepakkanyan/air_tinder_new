import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/auth/complete_profile/complete_profile.dart';
import 'package:air_tinder/view/auth/login.dart';
import 'package:air_tinder/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class SplashScreenProvider with ChangeNotifier {
  void checkIfLoggedIn(BuildContext context) {
    if (auth.currentUser != null) {
      Future.delayed(
        Duration(
          seconds: 2,
        ),
        () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => BottomNavBar(),
          ),
          (route) => false,
        ),
      );
    } else {
      Future.delayed(
        Duration(
          seconds: 2,
        ),
        () => Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => Login(),
          ),
          (route) => false,
        ),
      );
    }
  }
}
