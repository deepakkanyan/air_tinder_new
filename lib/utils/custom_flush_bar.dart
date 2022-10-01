import 'package:air_tinder/constant/color.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget showMsg(BuildContext context, String msg) {
  return Flushbar(
    backgroundColor: kSecondaryColor,
    message: msg,
    flushbarPosition: FlushbarPosition.BOTTOM,
    flushbarStyle: FlushbarStyle.FLOATING,
    messageColor: kPrimaryColor,
    messageSize: 12,
    duration: Duration(seconds: 3),
  )..show(context);
}
