import 'dart:developer';

import 'package:air_tinder/model/chat_model/chat_room_model.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/chat/chat_screen.dart';
import 'package:air_tinder/view/home/home_details.dart';
import 'package:air_tinder/view/widget/black_logo_app_bar.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/swipe_able_cards.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //List profiles = [];
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
            //profiles.add(doc);
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
      body: StreamBuilder(
        stream: profiles
            .where(
              'uId',
              isNotEqualTo: userDetailModel.uId,
            )
            .where(
              'gender',
              isEqualTo: userDetailModel.gender == "Male" ? "Female" : "Male",
            )
            .where(
              'layoverDetails.${"layoverAirPort"}',
              isEqualTo: userDetailModel.layoverDetails!["layoverAirPort"],
            )
            // .where(
            //   'layoverDetails.${"layoverCity"}',
            //   isEqualTo: userDetailModel.layoverDetails!["layoverCity"],
            // )
            .where(
              'layoverDetails.${"layoverLandingDate"}',
              isEqualTo: userDetailModel.layoverDetails!["layoverLandingDate"],
            )
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData && snapshot.data!.docs.length > 0) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: TCard(
                      size: Size(
                        width(1.0, context),
                        height(1.0, context),
                      ),
                      cards: List.generate(
                        snapshot.data!.docs.length,
                        (index) {
                          DocumentSnapshot docSnapShot =
                              snapshot.data!.docs[index];
                          UserDetailModel tUDM = UserDetailModel.fromJson(
                            docSnapShot.data() as Map<String, dynamic>,
                          );
                          return SwipeAbleCards(
                            images: tUDM.additionalImages!,
                            name: tUDM.fullName!,
                            flyingFrom:
                                '${tUDM.departureDetails!['departureAirPort']}, ${tUDM.departureDetails!['departureCity']}',
                            layover:
                                '${tUDM.layoverDetails!['layoverAirPort']}, ${tUDM.layoverDetails!['layoverCity']}',
                            landingAt:
                                '${tUDM.landingDetails!['landingAirport']}, ${tUDM.landingDetails!['landingCity']}',
                            onDislikeTap: () {},
                            // onTap: () {
                            //   // showDialog(
                            //   //   context: context,
                            //   //   builder: (_) {
                            //   //     return MatchDialog(
                            //   //       otherPersonName: 'Carolyn',
                            //   //       otherPersonImg: Assets.imagesDummyMan,
                            //   //     );
                            //   //   },
                            //   // );
                            // },
                            onLikeTap: () async {
                              await chatProvider.gotoChatScreen(
                                context,
                                tUDM,
                              );
                            },
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => HomeDetails(
                                  name: tUDM.fullName!,
                                  images: tUDM.additionalImages!,
                                  flyingFrom:
                                      '${tUDM.departureDetails!['departureAirPort']}, ${tUDM.departureDetails!['departureCity']}',
                                  layover:
                                      '${tUDM.layoverDetails!['layoverAirPort']}, ${tUDM.layoverDetails!['layoverCity']}',
                                  landingAt:
                                      '${tUDM.landingDetails!['landingAirport']}, ${tUDM.landingDetails!['landingCity']}',
                                  interests: tUDM.interests!,
                                  about: tUDM.about!,
                                  onLikeTap: () {},
                                  onDislikeTap: () {},
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            } else if (snapshot.hasError) {
              //log(snapshot.error.toString());
              return showMsg(context,
                  "Something went wrong: " + snapshot.error.toString());
            } else {
              return Center(
                child: MyText(
                  text: 'No Record Found!',
                ),
              );
            }
          } else {
            return loadingWidget(context);
          }
        },
      ),
    );
  }
}
