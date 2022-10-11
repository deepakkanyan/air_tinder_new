import 'dart:developer';

import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/my_drawer/my_drawer.dart';
import 'package:air_tinder/view/widget/black_logo_app_bar.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:air_tinder/view/widget/match_dialog.dart';
import 'package:air_tinder/view/widget/swipe_able_cards.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List profiles = [];
  bool isProfilesLoaded = false;

  void initState() {
    super.initState();
    getProfilesForSwipingScreen();
  }

  getProfilesForSwipingScreen() async {
    await fireStore.collection("Profiles").get().then((value) {
      for (var doc in value.docs) {
        log(doc["fullName"]);
        //logic
        log("firebase gender is " +
            doc["gender"] +
            "and" +
            " current user gender is " +
            userDetailModel.gender.toString());
        if (doc["gender"] != "" &&
            doc["gender"] != userDetailModel.gender.toString()) {
          log("firebase landingdateis is " +
              doc["layoverDetails"]["layoverLandingDate"] +
              "and" +
              " current landing date is " +
              userDetailModel.layoverDetails!["layoverLandingDate"]);

          log("firebase landingcityis is " +
              doc["layoverDetails"]["layoverCity"] +
              "and" +
              " current landing city is " +
              userDetailModel.layoverDetails!["layoverCity"]);

          log("firebase landing airport is " +
              doc["layoverDetails"]["layoverAirPort"] +
              "and" +
              " current landing airport is " +
              userDetailModel.layoverDetails!["layoverAirPort"]);

          if (doc["layoverDetails"]["layoverLandingDate"] ==
                  userDetailModel.layoverDetails!["layoverLandingDate"] &&
              doc["layoverDetails"]["layoverCity"].toString().trim() ==
                  userDetailModel.layoverDetails!["layoverCity"]
                      .toString()
                      .trim() &&
              doc["layoverDetails"]["layoverAirPort"].toString().trim() ==
                  userDetailModel.layoverDetails!["layoverAirPort"]
                      .toString()
                      .trim()) {
            profiles.add(doc);
          }
        }

        //
      }
      setState(() {
        isProfilesLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackLogoAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: isProfilesLoaded
                ? (profiles.length > 0)
                    ? TCard(
                        size: Size(
                          width(1.0, context),
                          height(1.0, context),
                        ),
                        cards: List.generate(
                          profiles.length,
                          (index) {
                            return SwipeAbleCards(
                              images: [profiles[index]["profileImage"]],
                              name: profiles[index]["fullName"],
                              flyingFrom: profiles[index]["departureDetails"]
                                      ["departureAirPort"] +
                                  ", " +
                                  profiles[index]["departureDetails"]
                                      ["departureCity"],
                              layover: profiles[index]["layoverDetails"]
                                      ["layoverAirPort"] +
                                  ", " +
                                  profiles[index]["layoverDetails"]
                                      ["layoverCity"],
                              landingAt: profiles[index]["landingDetails"]
                                      ["landingAirport"] +
                                  ", " +
                                  profiles[index]["landingDetails"]
                                      ["landingCity"],
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
                      )
                    : Text(
                        "No people that are gonna be at the layover are using the app")
                : Text("Waiting.."),
          ),
        ],
      ),
    );
  }
}
