import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/home/home_details.dart';
import 'package:air_tinder/view/widget/elevated_image.dart';
import 'package:air_tinder/view/widget/icon_tiles.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class SwipeAbleCards extends StatelessWidget {
  SwipeAbleCards({
    Key? key,
    required this.images,
    required this.name,
    required this.flyingFrom,
    required this.landingAt,
    required this.layover,
    required this.onDislikeTap,
    required this.onLikeTap,
    required this.onTap,
  }) : super(key: key);

  final String name, flyingFrom, layover, landingAt;
  final List images;
  final VoidCallback onDislikeTap, onLikeTap, onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: kPrimaryColor,
        boxShadow: [
          BoxShadow(
            blurRadius: 6,
            color: kTertiaryColor.withOpacity(0.16),
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ElevatedImage(
            image: images[0],
            onTap: onTap,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: onDislikeTap,
                      child: Image.asset(
                        Assets.imagesDislike,
                        height: 63,
                      ),
                    ),
                    GestureDetector(
                      onTap: onLikeTap,
                      child: Image.asset(
                        Assets.imagesLike,
                        height: 63,
                      ),
                    ),
                  ],
                ),
                MyText(
                  paddingTop: 15,
                  align: TextAlign.center,
                  text: '$name',
                  size: 18,
                  weight: FontWeight.w500,
                  paddingBottom: 15,
                ),
                IconTiles(
                  textColor: kTertiaryColor,
                  iconColor: kSecondaryColor,
                  icon: Assets.imagesDeparture,
                  title: 'Flying from: $flyingFrom',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: IconTiles(
                    textColor: kTertiaryColor,
                    iconColor: kSecondaryColor,
                    icon: Assets.imagesPlaneSolid,
                    title: ' Layover at: $layover',
                  ),
                ),
                IconTiles(
                  textColor: kTertiaryColor,
                  iconColor: kSecondaryColor,
                  icon: Assets.imagesPlaneArrival,
                  title: 'Landing at: $landingAt',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
