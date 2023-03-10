import 'package:air_tinder/constant/color.dart';
import 'package:flutter/material.dart';

Future<dynamic> loadingDialog(BuildContext context, {double? size = 50.0}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return Center(
        child: SizedBox(
          height: size,
          width: size,
          child: CircularProgressIndicator(
            color: kSecondaryColor,
          ),
        ),
      );
    },
  );
}

Widget loadingWidget(BuildContext context, {double? size = 50.0, Color? color}) {
  return Center(
    child: SizedBox(
      height: size,
      width: size,
      child: CircularProgressIndicator(
        color: color ?? kSecondaryColor,
      ),
    ),
  );
}
