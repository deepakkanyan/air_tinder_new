import 'dart:developer';

import 'package:air_tinder/model/complete_profile_model/what_makes_you_happy_model.dart';
import 'package:air_tinder/view/auth/complete_profile/about.dart';
import 'package:air_tinder/view/auth/complete_profile/add_photos.dart';
import 'package:air_tinder/view/auth/complete_profile/departue_details.dart';
import 'package:air_tinder/view/auth/complete_profile/interest.dart';
import 'package:air_tinder/view/auth/complete_profile/landing_details.dart';
import 'package:air_tinder/view/auth/complete_profile/layover_details.dart';
import 'package:air_tinder/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  int stackIndex = 0;

  void previousPage(BuildContext context) {
    if (stackIndex == 0) {
      Navigator.pop(context);
    } else {
      stackIndex--;
      notifyListeners();
    }
  }
}
