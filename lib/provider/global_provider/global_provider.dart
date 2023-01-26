import 'dart:developer';

import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  int stackIndex = 0;

  void updateStackIndex(BuildContext context, int index) {
    stackIndex = index;
    log("stackIndex : ${stackIndex}");
    notifyListeners();
  }

  void backButton(BuildContext context) {
    if (stackIndex == 0) {
      Navigator.pop(context);
    } else {
      stackIndex--;
      notifyListeners();
    }
  }
}
