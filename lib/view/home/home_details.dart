import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/elevated_image.dart';
import 'package:air_tinder/view/widget/icon_tiles.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:flutter/material.dart';

class HomeDetails extends StatefulWidget {
  HomeDetails({
    required this.name,
    required this.images,
    required this.flyingFrom,
    required this.layover,
    required this.landingAt,
    required this.onDislikeTap,
    required this.onLikeTap,
  });

  String? name, flyingFrom, layover, landingAt;
  List<String>? images;
  VoidCallback? onDislikeTap, onLikeTap;

  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  final pageController = PageController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: simpleAppBar(
        context: context,
        title: widget.name,
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: 7,
        ),
        children: [
          Container(
            height: 350,
            child: PageView.builder(
              controller: pageController,
              onPageChanged: (index) {
                setState(() {
                  currentIndex = index;
                });
              },
              itemCount: widget.images!.length,
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 15,
                  ),
                  child: ElevatedImage(
                    image: widget.images![index],
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images!.length,
              (index) {
                return AnimatedContainer(
                  duration: Duration(
                    microseconds: 300000,
                  ),
                  curve: Curves.easeInOut,
                  height: 5,
                  margin: EdgeInsets.symmetric(
                    horizontal: 2.5,
                  ),
                  width: currentIndex == index ? 54 : 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: kBrownColor,
                  ),
                );
              },
            ),
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
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: widget.onDislikeTap,
                      child: Image.asset(
                        Assets.imagesDislike,
                        height: 63,
                      ),
                    ),
                    GestureDetector(
                      onTap: widget.onLikeTap,
                      child: Image.asset(
                        Assets.imagesLike,
                        height: 63,
                      ),
                    ),
                  ],
                ),
                MyText(
                  paddingTop: 25,
                  text: widget.name,
                  size: 25,
                  weight: FontWeight.w500,
                ),
                MyText(
                  text: '25',
                  size: 16,
                  weight: FontWeight.w500,
                  paddingBottom: 10,
                ),
                IconTiles(
                  textColor: kTertiaryColor,
                  iconColor: kTertiaryColor,
                  icon: Assets.imagesDeparture,
                  title: 'Flying from: ${widget.flyingFrom}',
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: IconTiles(
                    textColor: kTertiaryColor,
                    iconColor: kTertiaryColor,
                    icon: Assets.imagesPlaneSolid,
                    title: ' Layover at: ${widget.layover}',
                  ),
                ),
                IconTiles(
                  textColor: kTertiaryColor,
                  iconColor: kTertiaryColor,
                  icon: Assets.imagesPlaneArrival,
                  title: 'Landing at: ${widget.landingAt}',
                ),
                MyText(
                  paddingTop: 15,
                  text: 'She likes:',
                  size: 16,
                  weight: FontWeight.w500,
                  paddingBottom: 10,
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: List.generate(
                    5,
                    (index) {
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          border: Border.all(
                            color: kSecondaryColor,
                            width: 1.0,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 3,
                        ),
                        child: MyText(
                          text: 'interest',
                          size: 14,
                          color: kSecondaryColor,
                        ),
                      );
                    },
                  ),
                ),
                MyText(
                  paddingTop: 15,
                  text:
                      'Sed a magna semper, porta purus eu, ullamcorper ligula. Nam sit amet consectetur sapien. Etiam dui ipsum, viverra vel turpis ut, dignissim elementum mauris. Sed dapibus auctor scelerisque. Aenean at leo tellus. Morbi eu leo sapien. Fusce libero dolor, venenatis eget enim sed, commodo efficitur arcu. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Fusce justo ipsum, placerat vitae erat ac, porttitor tincidunt lacus. In fermentum nulla nec fermentum tempus.',
                  align: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
