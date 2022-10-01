import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyButton extends StatelessWidget {
  MyButton({
    Key? key,
    this.buttonText,
    this.buttonIcon,
    this.iconSize,
    required this.onTap,
  }) : super(key: key);

  String? buttonText, buttonIcon;
  double? iconSize;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 3,
      highlightElevation: 3,
      onPressed: onTap,
      color: kSecondaryColor,
      splashColor: kPrimaryColor.withOpacity(0.1),
      highlightColor: kPrimaryColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      height: 45,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          MyText(
            paddingRight: 10,
            paddingBottom: 2,
            text: buttonText ?? 'Continue',
            size: 16,
            weight: FontWeight.w500,
            color: kPrimaryColor,
          ),
          Image.asset(
            buttonIcon ?? Assets.imagesArrowForward,
            height: iconSize ?? 12,
          ),
        ],
      ),
    );
  }
}
