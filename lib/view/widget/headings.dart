import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AuthSubHeading extends StatelessWidget {
  AuthSubHeading({
    Key? key,
    required this.subHeading,
    this.color,
  }) : super(key: key);
  String subHeading;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return MyText(
      paddingTop: 7,
      paddingBottom: 20,
      text: subHeading,
      size: 14,
      color: color ?? kTertiaryColor,
    );
  }
}

// ignore: must_be_immutable
class AuthHeading extends StatelessWidget {
  AuthHeading({
    Key? key,
    required this.heading,
    this.color,
  }) : super(key: key);
  String heading;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return MyText(
      text: heading,
      size: 18,
      weight: FontWeight.w500,
      color: color ?? kTertiaryColor,
    );
  }
}
