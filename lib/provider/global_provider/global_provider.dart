import 'package:flutter/material.dart';

class GlobalProvider with ChangeNotifier {
  int stackIndex = 0;

  void updateStackIndex(BuildContext context, int index) {
    stackIndex = index;
    notifyListeners();
  }
}
