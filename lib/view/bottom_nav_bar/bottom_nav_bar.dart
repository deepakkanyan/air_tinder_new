import 'dart:developer';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/chat/chat_heads.dart';
import 'package:air_tinder/view/home/home.dart';
import 'package:air_tinder/view/layover_surround/layover_surround.dart';
import 'package:air_tinder/view/settings/settings.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  List<String> items = [
    Assets.imagesHome,
    Assets.imagesLoc,
    Assets.imagesMsg,
    Assets.imagesSettings,
  ];

  int currentIndex = 0;

  final List<Widget> screens = [
    Home(),
    LayoverSurround(),
    ChatHeads(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 64,
        decoration: BoxDecoration(
          color: kPrimaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [
            BoxShadow(
              color: kTertiaryColor.withOpacity(0.16),
              blurRadius: 6,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          onTap: (index) {
            setState(() {
              currentIndex = index;
              log(currentIndex.toString());
            });
          },
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: kSecondaryColor,
          unselectedItemColor: kTertiaryColor,
          items: List.generate(
            items.length,
            (index) {
              return BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage(
                    items[index],
                  ),
                  size: 28,
                ),
                label: '',
              );
            },
          ),
        ),
      ),
    );
  }
}
