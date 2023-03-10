import 'dart:developer';

import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/model/chat_model/chat_room_model.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/chat/chat_screen.dart';
import 'package:air_tinder/view/widget/black_logo_app_bar.dart';
import 'package:air_tinder/view/widget/chat_head_tiles.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/profile_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatHeads extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BlackLogoAppBar(),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: 20,
        ),
        children: [
          MyText(
            text: 'New Matches',
            size: 16,
            paddingLeft: 15,
            paddingBottom: 5,
          ),
          Container(
            height: 55,
            child: StreamBuilder(
              stream: fireStore
                  .collection('Likes')
                  //+Commented
                  // .where("direction", isEqualTo: "twoway")
                  // .where("participants", arrayContains: userDetailModel.uId)
                  // .where("chatInitiated", isNotEqualTo: true)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.active) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: BouncingScrollPhysics(),
                      itemCount: snapshot.data?.docs.length,
                      padding: EdgeInsets.symmetric(horizontal: 7.5),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> doc = snapshot.data?.docs[index].data() as Map<String, dynamic>;
                        String likesDocId = snapshot.data?.docs[index].id ?? "";
                        String likedDoc = doc["liked"] == (userDetailModel.uId ?? "") ? doc["likedBy"] : doc["liked"];
                        CollectionReference collReference = fireStore.collection('Profiles');
                        if(likedDoc.isNotEmpty){
                          collReference.doc(likedDoc);
                        }
                        return FutureBuilder(
                          future: collReference
                              .get(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot is DocumentSnapshot) {
                              DocumentSnapshot documentSnapshot = snapshot.data as DocumentSnapshot;
                              UserDetailModel otherUserModel =
                                  UserDetailModel.fromJson(documentSnapshot.data() as Map<String, dynamic>);

                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 7.5),
                                child: GestureDetector(
                                  onTap: () async {
                                    await chatProvider.getChatRooms(context, otherUserModel, likesDocId);
                                  },
                                  child: ProfileImage(
                                    imgURL: otherUserModel.profileImgUrl ?? "",
                                    size: 55,
                                  ),
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return loadingWidget(context);
                            } else {
                              return MyText(text: "No New Matches!");
                            }
                          },
                        );
                      },
                    );
                  } else if (snapshot.hasError) {
                    log(snapshot.error.toString());
                    return loadingWidget(context);
                  } else {
                    return MyText(
                      text: 'No new matches!',
                    );
                  }
                } else {
                  return loadingWidget(context);
                }
              },
            ),
          ),
          MyText(text: 'Messages', size: 16, paddingTop: 15, paddingLeft: 15, paddingBottom: 5),
          StreamBuilder(
            stream: fireStore
                .collection('ChatRooms')
                .where('participants', arrayContains: userDetailModel.uId)
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      ChatRoomModel chatHeadModel =
                          ChatRoomModel.fromJson(snapshot.data?.docs[index].data() as Map<String, dynamic>);
                      List<dynamic> _participants = chatHeadModel.participants;
                      log("current user uid :  ${auth.currentUser?.uid}");
                      log("_participants ${_participants}");

                      return FutureBuilder(
                        future: fireStore
                            .collection('Profiles')
                            .doc(_participants[0] == userDetailModel.uId ? _participants[1] : _participants[0])
                            .get(),
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {

                            DocumentSnapshot docSnapShot = snapShot.data as DocumentSnapshot;
                            UserDetailModel otherUserModel =
                                UserDetailModel.fromJson(docSnapShot.data() as Map<String, dynamic>);
                            // log("otherUserModel  ${otherUserModel.toJson()}");
                            return ChatHeadsTiles(
                              imageURL: otherUserModel.profileImgUrl!,
                              name: otherUserModel.fullName ?? "",
                              lastMsg: chatHeadModel.lastMsg ?? "",
                              time: chatHeadModel.lstMsgTime ?? "",
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatScreen(chatHeadModel: chatHeadModel, otherUserModel: otherUserModel),
                                ),
                              ),
                            );
                          } else if (snapShot.hasError) {
                            return loadingWidget(context);
                          } else {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 40),
                              child: loadingWidget(
                                context,
                                size: 25,
                              ),
                            );
                          }
                        },
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  log(snapshot.error.toString());
                  return loadingWidget(context);
                } else {
                  return MyText(
                    text: 'There are no chats yet!',
                  );
                }
              } else {
                return loadingWidget(context);
              }
            },
          )
        ],
      ),
    );
  }
}
