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

class DepartureDetailsProvider with ChangeNotifier {
  TextEditingController cityCon = TextEditingController();
  TextEditingController airportCon = TextEditingController();
  TextEditingController departureDateCon = TextEditingController();
  TextEditingController departureTimeCon = TextEditingController();
  DateTime departureDate = DateTime.now();
  DateTime departureTime = DateTime.now();

  Future<void> uploadData(BuildContext context, bool isForEdit) async {
    if (cityCon.text.isEmpty && cityCon.text == '') {
      showMsg(context, 'Please provide city name');
    } else if (airportCon.text.isEmpty && airportCon.text == '') {
      showMsg(context, 'Please provide Airport name');
    } else if (departureDateCon.text.isEmpty && departureDateCon.text == '') {
      showMsg(context, 'Please enter departure date');
    } else if (departureTimeCon.text.isEmpty && departureTimeCon.text == '') {
      showMsg(context, 'Please enter departure time');
    } else {
      try {
        loadingDialog(context);
        await profiles.doc(auth.currentUser!.uid).update({
          'departureDetails': {
            'departureCity': cityCon.text,
            'departureAirPort': airportCon.text,
            'departureDate': departureDateCon.text,
            'departureTime': departureTimeCon.text,
          },
        });
        Navigator.pop(context);
        isForEdit
            ? null
            : Provider.of<GlobalProvider>(context, listen: false)
                .updateStackIndex(context, 4);
        isForEdit
            ? showMsg(
                context,
                'Successfully Updated!',
                bgColor: kSuccessColor,
              )
            : null;
        cityCon.clear();
        airportCon.clear();
        departureDateCon.clear();
        departureTimeCon.clear();
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showMsg(context, e.message.toString());
      }
    }
  }

  void onDateChanged(DateTime value) {
    departureDate = value;
    notifyListeners();
  }

  void setDepartureDate(BuildContext context) {
    departureDateCon.text = DateFormat.yMEd().format(departureDate).toString();
    Navigator.pop(context);
    notifyListeners();
  }

  void onTimeChanged(DateTime value) {
    departureTime = value;
    notifyListeners();
  }

  void setDepartureTime(BuildContext context) {
    departureTimeCon.text = DateFormat.jms().format(departureTime).toString();
    Navigator.pop(context);
    notifyListeners();
  }
}
