import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class LayoverRadarDialog extends StatelessWidget {
  const LayoverRadarDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(20),
            margin: EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(
                  Assets.imagesRedBg,
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyText(
                  text: 'Welcome to the Layover Radar',
                  size: 18,
                  weight: FontWeight.w500,
                  color: kPrimaryColor,
                  align: TextAlign.center,
                ),
                MyText(
                  paddingTop: 15,
                  text:
                  'This radar is active when you are at the layover. It shows you people who are using the app and are also at the layover. You can click on the people found in the radar and go to their profile to see their info. You can send them a like. If they like you back a match happens and you can start chatting. Isn\'t this amazing?',
                  size: 12,
                  weight: FontWeight.w300,
                  align: TextAlign.center,
                  color: kPrimaryColor,
                  paddingBottom: 15,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}