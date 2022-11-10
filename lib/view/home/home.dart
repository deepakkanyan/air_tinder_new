import 'dart:async';
import 'dart:developer';

import 'package:air_tinder/generated/assets.dart';
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
import 'package:air_tinder/view/widget/match_dialog.dart';
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
  TCardController _tCardController = TCardController();
  List<String> usersAlreadyLiked = [];
  bool isUsersAlreadyLikedLoaded = false;
  bool isChatLoading = false;

  void initState() {
    super.initState();
    getUsersAlreadyLikedCollection();
    //getProfilesForSwipingScreen();
  }

  getUsersAlreadyLikedCollection() async {
    await likes.get().then((value) {
      for (var doc in value.docs) {
        if ((doc["likedBy"] == userDetailModel.uId)) {
          usersAlreadyLiked.add(doc["liked"]);
        }
        if ((doc["liked"] == userDetailModel.uId &&
            doc["direction"] == "twoway")) {
          usersAlreadyLiked.add(doc["likedBy"]);
        }
      }
    });
    setState(() {
      isUsersAlreadyLikedLoaded = true;
    });
  }

  void initiateChatFromMatchPopup(
      BuildContext context, UserDetailModel tUDM, String likesDocId) async {
    await chatProvider.gotoChatScreen(context, tUDM, likesDocId);
  }

  // getProfilesForSwipingScreen() async {
  //   await fireStore.collection("Profiles").get().then((value) {
  //     for (var doc in value.docs) {
  //       log(doc["fullName"]);
  //       //logic
  //       log("firebase gender is " +
  //           doc["gender"] +
  //           "and" +
  //           " current user gender is " +
  //           userDetailModel.gender.toString());
  //       if (doc["gender"] != "" &&
  //           doc["gender"] != userDetailModel.gender.toString()) {
  //         log("firebase landingdateis is " +
  //             doc["layoverDetails"]["layoverLandingDate"] +
  //             "and" +
  //             " current landing date is " +
  //             userDetailModel.layoverDetails!["layoverLandingDate"]);

  //         log("firebase landingcityis is " +
  //             doc["layoverDetails"]["layoverCity"] +
  //             "and" +
  //             " current landing city is " +
  //             userDetailModel.layoverDetails!["layoverCity"]);

  //         log("firebase landing airport is " +
  //             doc["layoverDetails"]["layoverAirPort"] +
  //             "and" +
  //             " current landing airport is " +
  //             userDetailModel.layoverDetails!["layoverAirPort"]);

  //         if (doc["layoverDetails"]["layoverLandingDate"] ==
  //             userDetailModel.layoverDetails!["layoverLandingDate"] &&
  //             doc["layoverDetails"]["layoverCity"].toString().trim() ==
  //                 userDetailModel.layoverDetails!["layoverCity"]
  //                     .toString()
  //                     .trim() &&
  //             doc["layoverDetails"]["layoverAirPort"].toString().trim() ==
  //                 userDetailModel.layoverDetails!["layoverAirPort"]
  //                     .toString()
  //                     .trim()) {
  //           //profiles.add(doc);
  //         }
  //       }

  //       //
  //     }
  //     setState(() {
  //       isProfilesLoaded = true;
  //     });
  //   });
  // }

  Future<void> onLikeTap(UserDetailModel tUDM) async {
    // await chatProvider.gotoChatScreen(
    //   context,
    //   tUDM,
    // );
    bool otherUserHasAlreadyLiked = false;
    //check if the user is already liked by the one being liked
    await likes.get().then((value) async {
      for (var doc in value.docs) {
        if (doc["liked"] == userDetailModel.uId &&
            doc["likedBy"] == tUDM.uId &&
            doc["type"] == "like") {
          //update the doc in collection
          await likes.doc(doc.id).update({'direction': 'twoway'});
          //open the its a match popup
          showDialog(
            context: context,
            builder: (_) {
              return MatchDialog(
                otherPersonName: tUDM.fullName,
                otherPersonImg: tUDM.profileImgUrl,
                onMessageTapMethod: initiateChatFromMatchPopup,
                context: context,
                tUDM: tUDM,
                likesDocId: doc.id,
              );
            },
          );
          otherUserHasAlreadyLiked = true;
        } else if (doc["liked"] == userDetailModel.uId &&
            doc["likedBy"] == tUDM.uId &&
            doc["type"] == "dislike") {
          await likes.doc(doc.id).update({'direction': 'conflict'});

          otherUserHasAlreadyLiked = true;
        }
      }

      if (otherUserHasAlreadyLiked == false) {
        await likes.add({
          'likedBy': userDetailModel.uId,
          'liked': tUDM.uId,
          'direction': 'oneway',
          'type': 'like',
          'chatInitiated': false,
          'participants': [userDetailModel.uId, tUDM.uId],
        });
      }
    });

    //
  }

  Future<void> onDislikeTap(UserDetailModel tUDM) async {
    bool otherUserHasAlreadyLiked = false;
    //check if the user is already liked by the one being liked
    await likes.get().then((value) async {
      for (var doc in value.docs) {
        if (doc["liked"] == userDetailModel.uId && doc["likedBy"] == tUDM.uId) {
          //update the doc in collection
          await likes.doc(doc.id).update({'direction': 'rejected'});
          //open the its a match popup

          otherUserHasAlreadyLiked = true;
        }
      }

      if (otherUserHasAlreadyLiked == false) {
        await likes.add({
          'likedBy': userDetailModel.uId,
          'liked': tUDM.uId,
          'direction': 'oneway',
          'type': 'dislike',
          'chatInitiated': false,
          'participants': [userDetailModel.uId, tUDM.uId],
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isUsersAlreadyLikedLoaded
        ? Scaffold(
            appBar: BlackLogoAppBar(),
            body: StreamBuilder(
              stream: profiles
                  .where(
                    'uId',
                    isNotEqualTo: userDetailModel.uId,
                  )
                  .where(
                    'gender',
                    isEqualTo:
                        userDetailModel.gender == "Male" ? "Female" : "Male",
                  )
                  .where(
                    'layoverDetails.${"layoverAirPort"}',
                    isEqualTo:
                        userDetailModel.layoverDetails!["layoverAirPort"],
                  )
                  .where(
                    'layoverDetails.${"layoverCity"}',
                    isEqualTo: userDetailModel.layoverDetails!["layoverCity"],
                  )
                  .where(
                    'layoverDetails.${"layoverLandingDate"}',
                    isEqualTo:
                        userDetailModel.layoverDetails!["layoverLandingDate"],
                  )
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  var profilesToPopulate = snapshot.data!.docs;
                  var docsToRemove = [];

                  for (var doc in profilesToPopulate) {
                    if (usersAlreadyLiked.contains(doc.id)) {
                      docsToRemove.add(doc);
                    }
                  }

                  if (docsToRemove.length > 0) {
                    for (var doc in docsToRemove) {
                      profilesToPopulate.remove(doc);
                    }
                  }

                  if (snapshot.hasData && profilesToPopulate.length > 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: TCard(
                            controller: _tCardController,
                            size: Size(
                              width(1.0, context),
                              height(1.0, context),
                            ),
                            onForward: (index, SwipInfo) {
                              DocumentSnapshot docSnapShot =
                                  profilesToPopulate[index - 1];
                              UserDetailModel tUDM = UserDetailModel.fromJson(
                                docSnapShot.data() as Map<String, dynamic>,
                              );
                              if (SwipInfo.direction == SwipDirection.Right) {
                                onLikeTap(tUDM);
                              } else if (SwipInfo.direction ==
                                  SwipDirection.Left) {
                                onDislikeTap(tUDM);
                              }
                            },
                            cards: List.generate(
                              profilesToPopulate.length,
                              (index) {
                                DocumentSnapshot docSnapShot =
                                    profilesToPopulate[index];
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
                                  onDislikeTap: () {
                                    _tCardController.forward(
                                        direction: SwipDirection.Left);
                                  },
                                  onLikeTap: () {
                                    _tCardController.forward(
                                        direction: SwipDirection.Right);
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
            ))
        : loadingWidget(context);
  }
}
