import 'package:flutter/cupertino.dart';

class EditProfileProvider with ChangeNotifier {
  TextEditingController fullNameCon = TextEditingController();
  TextEditingController dobCon = TextEditingController();
  TextEditingController aboutCon = TextEditingController();
  String selectedGender = '';
  int genderIndex = 0;

  void setGender(
    int index,
    String gender,
  ) {
    genderIndex = index;
    selectedGender = gender;
    notifyListeners();
  }
}
