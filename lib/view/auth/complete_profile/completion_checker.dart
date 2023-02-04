import 'dart:developer';
import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/provider/global_provider/global_provider.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/auth/complete_profile/complete_profile.dart';
import 'package:air_tinder/view/bottom_nav_bar/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class CompletionChecker extends StatefulWidget {
  CompletionChecker({required this.uID});

  String uID;

  @override
  State<CompletionChecker> createState() => _CompletionCheckerState();
}

class _CompletionCheckerState extends State<CompletionChecker> {
  @override
  void initState() {
    super.initState();
    _setProfileStep();
  }

  void _setProfileStep() async {
    final _sProvider = Provider.of<GlobalProvider>(context, listen: false);
    await profiles.doc(auth.currentUser!.uid).get().then((value) async {
      Map<String, dynamic> data = value.data() as Map<String, dynamic>;
      if (value.exists) {
        if (data['profileImage'] == null) {
          setState(() {
            _sProvider.stackIndex = 0;
            isLoading = false;
            showMsg(context, 'Please upload your photo!');
          });
        } else if (data['dateOfBirth'] == null) {
          setState(() {
            _sProvider.stackIndex = 0;
            isLoading = false;
            showMsg(context, 'Date Of Birth Cannot Be Empty!');
          });
        } else if (data['interests'] == null) {
          setState(() {
            _sProvider.stackIndex = 1;
            isLoading = false;
            showMsg(context, 'Choose minimum 3 interests!');
          });
        } else if (data['about'] == null) {
          print(" Checking profile data['about']: ${data['about']}");

          setState(() {
            _sProvider.stackIndex = 2;
            isLoading = false;
            showMsg(context, 'Field Cannot Be Empty!');
          });
        } /*else if (data['departureDetails'] == null) {
          print(" Checking profile data['departureDetails']: ${data['departureDetails']}");
          setState(() {
            _sProvider.stackIndex = 3;
            isLoading = false;
            showMsg(context, 'Please fill departure details');
          });
        } */else if (data['layoverDetails'] == null) {
          setState(() {
            _sProvider.stackIndex = 4;
            isLoading = false;
            showMsg(context, 'Please fill layover details');
          });
        } /*else if (data['landingDetails'] == null) {
          setState(() {
            _sProvider.stackIndex = 5;
            isLoading = false;
            showMsg(context, 'Please fill landing details');
          });
        }*/ else {
          await profiles.doc(auth.currentUser!.uid).get().then((value) {
            userDetailModel = UserDetailModel.fromJson(value.data() as Map<String, dynamic>);
            log(userDetailModel.profileImgUrl!);
          });
          setState(() {
            _sProvider.stackIndex = 0;
            isCompleted = true;
            isLoading = false;
          });
        }
      }
    });
  }

  bool isCompleted = false;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return isCompleted
        ? BottomNavBar()
        : isLoading
            ? Scaffold(
                body: Center(
                  child: SizedBox(
                    height: 50,
                    width: 50,
                    child: CircularProgressIndicator(
                      color: kSecondaryColor,
                    ),
                  ),
                ),
              )
            : CompleteProfile();
  }
}
