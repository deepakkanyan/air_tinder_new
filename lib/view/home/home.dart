import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/my_drawer/my_drawer.dart';
import 'package:air_tinder/view/widget/black_logo_app_bar.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:air_tinder/view/widget/match_dialog.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/swipe_able_cards.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: BlackLogoAppBar(),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: TCard(
                  size: Size(
                    width(1.0, context),
                    height(1.0, context),
                  ),
                  cards: List.generate(
                    5,
                    (index) {
                      return SwipeAbleCards(
                        images: [
                          Assets.imagesGirl,
                          Assets.imagesGirl,
                          Assets.imagesGirl,
                          Assets.imagesGirl,
                        ],
                        name: 'Carolyn Hudson',
                        flyingFrom: 'JFK Airport, New York',
                        layover: 'London City Airport, London',
                        landingAt: 'Dubai International Airport, Dubai',
                        onDislikeTap: () {},
                        onLikeTap: () {
                          showDialog(
                            context: context,
                            builder: (_) {
                              return MatchDialog(
                                otherPersonName: 'Carolyn',
                                otherPersonImg: Assets.imagesDummyMan,
                              );
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
          completeProfileFirst(context),
        ],
      ),
    );
  }

  Widget completeProfileFirst(BuildContext context) {
    return Container(
      height: height(1.0, context),
      color: kSecondaryColor.withOpacity(0.1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 15,
            ),
            width: width(1.0, context),
            color: kSecondaryColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyText(
                  text: 'Please complete your profile',
                  color: kPrimaryColor,
                  size: 16,
                  paddingBottom: 5,
                ),
                MyText(
                  text:
                      'In order to use application you have to complete your profile first.',
                  size: 12,
                  weight: FontWeight.w300,
                  color: kPrimaryColor.withOpacity(0.8),
                ),
                MyText(
                  align: TextAlign.end,
                  text: 'Complete Profile',
                  size: 10,
                  decoration: TextDecoration.underline,
                  weight: FontWeight.w500,
                  color: kPrimaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
