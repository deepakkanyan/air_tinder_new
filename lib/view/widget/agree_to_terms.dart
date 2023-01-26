import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

Widget agreeToTerms() {
  return MyText(
    text:
        'By signing up to JetLatch to agree to our EULA, privacy policy and terms of use.',
    color: kPrimaryColor,
    size: 12,
    weight: FontWeight.w300,
    align: TextAlign.center,
  );
}
