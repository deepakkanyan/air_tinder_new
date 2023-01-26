import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LayoverDetailsProvider with ChangeNotifier {
  TextEditingController cityCon = TextEditingController();
  TextEditingController airportCon = TextEditingController();
  TextEditingController landingDateCon = TextEditingController();
  TextEditingController landingTimeCon = TextEditingController();
  TextEditingController stayCon = TextEditingController();
  DateTime landingDate = DateTime.now();
  DateTime landingTime = DateTime.now();
  DateTime stayTime = DateTime.now();

  Future<void> uploadData(BuildContext context, bool isForEdit) async {
    if (cityCon.text.isEmpty && cityCon.text == '') {
      showMsg(context, 'Please provide layover city name');
    } else if (airportCon.text.isEmpty && airportCon.text == '') {
      showMsg(context, 'Please provide layover airport name');
    } else if (landingDateCon.text.isEmpty && landingDateCon.text == '') {
      showMsg(context, 'Please enter layover landing date');
    } else if (landingTimeCon.text.isEmpty && landingTimeCon.text == '') {
      showMsg(context, 'Please enter layover landing time');
    } else if (stayCon.text.isEmpty && stayCon.text == '') {
      showMsg(context, 'Please enter layover stay time');
    } else {
      try {
        loadingDialog(context);
        await profiles.doc(auth.currentUser!.uid).update({
          'layoverDetails': {
            'layoverCity': cityCon.text,
            'layoverAirPort': airportCon.text,
            'layoverLandingDate': landingDateCon.text,
            'layoverLandingTime': landingTimeCon.text,
            'layoverStayTime': landingTimeCon.text,
          },
        });
        print("Profile Update Successfully !");

        Navigator.pop(context);
        isForEdit ? null : Provider.of<GlobalProvider>(context, listen: false).updateStackIndex(context, 6);
        isForEdit
            ? showMsg(
                context,
                'Successfully Updated!',
                bgColor: kSuccessColor,
              )
            : null;
        cityCon.clear();
        airportCon.clear();
        landingDateCon.clear();
        landingTimeCon.clear();
        stayCon.clear();
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showMsg(context, e.message.toString());
      }
    }
  }

  void onLandingDateChanged(DateTime value) {
    landingDate = value;
    notifyListeners();
  }

  void setLayOverLandingDate(BuildContext context) {
    landingDateCon.text = DateFormat.yMEd().format(landingDate).toString();
    Navigator.pop(context);
    notifyListeners();
  }

  void onLandingTimeChanged(DateTime value) {
    landingTime = value;
    notifyListeners();
  }

  void setLandingTime(BuildContext context) {
    landingTimeCon.text = DateFormat.yMEd().format(landingTime).toString();
    Navigator.pop(context);
    notifyListeners();
  }

  void onStayTimeChanged(DateTime value) {
    stayTime = value;
    notifyListeners();
  }

  void setStayTime(BuildContext context) {
    stayCon.text = DateFormat.yMEd().format(stayTime).toString();
    Navigator.pop(context);
    notifyListeners();
  }
}
