import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class EditFlightTiles extends StatelessWidget {
  EditFlightTiles({
    Key? key,
    this.icon,
    this.title,
    this.onTap,
  }) : super(key: key);
  String? icon, title;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: kPrimaryColor,
          width: 1.0,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(5),
          splashColor: kPrimaryColor.withOpacity(0.1),
          highlightColor: kPrimaryColor.withOpacity(0.1),
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Row(
              children: [
                Image.asset(
                  icon.toString(),
                  height: 16.3,
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: MyText(
                    text: title,
                    size: 11,
                    weight: FontWeight.w500,
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}