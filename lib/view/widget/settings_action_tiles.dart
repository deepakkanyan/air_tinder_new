import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class SettingsActionTiles extends StatelessWidget {
  SettingsActionTiles({
    Key? key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);
  String? icon, title;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.only(
          bottom: 15,
        ),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: kPrimaryColor,
            ),
          ),
        ),
        child: Row(
          children: [
            Image.asset(
              icon.toString(),
              height: 44,
            ),
            Expanded(
              child: MyText(
                paddingLeft: 15,
                text: '$title',
                size: 16,
                weight: FontWeight.w500,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}