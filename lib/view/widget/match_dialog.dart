import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/simple_button.dart';
import 'package:flutter/material.dart';

class MatchDialog extends StatelessWidget {
  MatchDialog({
    Key? key,
    this.otherPersonImg,
    this.otherPersonName,
  }) : super(key: key);

  String? otherPersonImg, otherPersonName;

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
                Container(
                  height: 100,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            otherPersonImg!,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 50,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            Assets.imagesGirl,
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Center(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(
                            Assets.imagesHeartSolid,
                            height: 27.16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    MyText(
                      text: 'It\'s a match',
                      size: 18,
                      weight: FontWeight.w500,
                      color: kPrimaryColor,
                      align: TextAlign.center,
                      paddingRight: 10,
                    ),
                    Image.asset(
                      Assets.imagesEmoji,
                      height: 16.82,
                    ),
                  ],
                ),
                MyText(
                  paddingTop: 15,
                  text:
                  'You and $otherPersonName have liked each other. Isn\'t it amazing. We are proud to have made your travel more interesting. Message her and talk about meeting at the layover.',
                  size: 12,
                  weight: FontWeight.w300,
                  align: TextAlign.center,
                  color: kPrimaryColor,
                  paddingBottom: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 150,
                      child: SimpleButton(
                        buttonText: 'Message',
                        onTap: () {},
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