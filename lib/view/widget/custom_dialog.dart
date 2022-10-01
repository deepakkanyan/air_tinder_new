import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  CustomDialog({
    Key? key,
    this.content,
    this.heading,
    this.onYesTap,
    this.onNoTap,
  }) : super(key: key);
  String? heading, content;
  VoidCallback? onYesTap, onNoTap;

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
                  text: '$heading',
                  size: 18,
                  weight: FontWeight.w500,
                  color: kPrimaryColor,
                  align: TextAlign.center,
                ),
                MyText(
                  paddingTop: 15,
                  text: '$content',
                  size: 12,
                  weight: FontWeight.w300,
                  align: TextAlign.center,
                  color: kPrimaryColor,
                  paddingBottom: 15,
                ),
                Row(
                  children: [
                    Expanded(
                      child: SimpleButton(
                        buttonText: 'Yes',
                        onTap: onYesTap,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: SimpleButton(
                        buttonText: 'No',
                        onTap: onNoTap,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
