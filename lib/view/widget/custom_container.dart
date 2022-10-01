import 'package:air_tinder/constant/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  CustomContainer({
    Key? key,
    required this.child,
  }) : super(key: key);
  Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      margin: EdgeInsets.only(
        top: 130,
        left: 15,
        right: 15,
        bottom: 20,
      ),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(0.80),
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }
}
