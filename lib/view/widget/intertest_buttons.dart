import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/provider/auth_provider/auth_provider.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InterestButtons extends StatelessWidget {
  InterestButtons({
    Key? key,
    this.interest,
    this.isSelected = false,
    this.index,
    this.onTap,
  }) : super(key: key);

  String? interest;
  bool? isSelected;
  int? index;

  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected! ? kSecondaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: kSecondaryColor,
          width: 1.0,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(5),
        splashColor: kSecondaryColor.withOpacity(0.05),
        highlightColor: kSecondaryColor.withOpacity(0.05),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 4,
          ),
          child: MyText(
            text: interest,
            color: isSelected! ? kPrimaryColor : kTertiaryColor,
          ),
        ),
      ),
    );
  }
}
