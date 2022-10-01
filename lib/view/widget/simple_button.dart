import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class SimpleButton extends StatelessWidget {
  SimpleButton({
    Key? key,
    this.onTap,
    this.buttonText,
    this.height = 35.0,
    this.bgColor,
    this.textColor,
  }) : super(key: key);
  String? buttonText;
  VoidCallback? onTap;
  double? height;

  Color? bgColor, textColor;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onTap,
      height: height,
      color: bgColor ?? kPrimaryColor,
      elevation: 3,
      highlightElevation: 3,
      splashColor: kSecondaryColor.withOpacity(0.05),
      highlightColor: kSecondaryColor.withOpacity(0.05),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: MyText(
          text: buttonText,
          size: 16,
          weight: FontWeight.w500,
          color: textColor ?? kSecondaryColor,
        ),
      ),
    );
  }
}
