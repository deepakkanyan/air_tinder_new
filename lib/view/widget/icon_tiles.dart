import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class IconTiles extends StatelessWidget {
  IconTiles({
    Key? key,
    this.title,
    this.icon,
    this.textColor,
    this.iconColor,
  }) : super(key: key);
  String? icon, title;
  Color? textColor, iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon.toString(),
          height: 16.3,
          color: iconColor ?? kPrimaryColor,
        ),
        SizedBox(
          width: 15,
        ),
        Expanded(
          child: MyText(
            text: title,
            size: 12,
            weight: FontWeight.w500,
            color: textColor ?? kPrimaryColor,
          ),
        ),
      ],
    );
  }
}
