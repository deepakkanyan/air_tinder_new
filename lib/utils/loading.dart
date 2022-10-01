import 'package:air_tinder/constant/color.dart';
import 'package:flutter/material.dart';

Future<dynamic> loading(
  BuildContext context, {
  double? size = 50.0,
}) {
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
