import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/my_drawer/my_drawer.dart';
import 'package:air_tinder/view/widget/black_logo_app_bar.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:air_tinder/view/widget/match_dialog.dart';
import 'package:air_tinder/view/widget/swipe_able_cards.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: BlackLogoAppBar(),
      body: Column(
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
    );
  }
}
