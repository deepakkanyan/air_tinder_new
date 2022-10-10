import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class LandingDetailsProvider with ChangeNotifier {
  TextEditingController cityCon = TextEditingController();
  TextEditingController airportCon = TextEditingController();
  TextEditingController landingDateCon = TextEditingController();
  TextEditingController landingTimeCon = TextEditingController();
  DateTime landingDate = DateTime.now();
  DateTime landingTime = DateTime.now();

  Future<void> uploadData(
    BuildContext context,
    bool isForEdit,
  ) async {
    if (cityCon.text.isEmpty && cityCon.text == '') {
      showMsg(context, 'Please provide city name');
    } else if (airportCon.text.isEmpty && airportCon.text == '') {
      showMsg(context, 'Please provide Airport name');
    } else if (landingDateCon.text.isEmpty && landingDateCon.text == '') {
      showMsg(context, 'Please enter landing date');
    } else if (landingTimeCon.text.isEmpty && landingTimeCon.text == '') {
      showMsg(context, 'Please enter landing time');
    } else {
      try {
        loadingDialog(context);
        await profiles.doc(auth.currentUser!.uid).update({
          'landingDetails': {
            'landingCity': cityCon.text,
            'landingAirport': airportCon.text,
            'landingDate': landingDateCon.text,
            'landingTime': landingTimeCon.text,
          },
        });
        Navigator.pop(context);
        isForEdit
            ? null
            : Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (_) => BottomNavBar(),
                ),
                (route) => false,
              );
        isForEdit
            ? null
            : Provider.of<GlobalProvider>(context, listen: false)
                .updateStackIndex(context, 0);
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
        isForEdit
            ? null
            : await profiles.doc(auth.currentUser!.uid).get().then(
                (value) {
                  userDetailModel = UserDetailModel.fromJson(
                    value.data() as Map<String, dynamic>,
                  );
                },
              );
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        showMsg(context, e.message.toString());
      }
    }
  }

  void onDateChanged(DateTime value) {
    landingDate = value;
    notifyListeners();
  }

  void setLandingDate(BuildContext context) {
    landingDateCon.text = DateFormat.yMEd().format(landingDate).toString();
    Navigator.pop(context);
    notifyListeners();
  }

  void onTimeChanged(DateTime value) {
    landingTime = value;
    notifyListeners();
  }

  void setLandingTime(BuildContext context) {
    landingTimeCon.text = DateFormat.jms().format(landingTime).toString();
    Navigator.pop(context);
    notifyListeners();
  }
}
