import 'dart:developer';

import 'package:air_tinder/model/chat_model/chat_room_model.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/chat/chat_screen.dart';
import 'package:air_tinder/view/widget/black_logo_app_bar.dart';
import 'package:air_tinder/view/widget/chat_head_tiles.dart';
import 'package:air_tinder/view/widget/my_text.dart';
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
          // MyText(
          //   text: 'New matches',
          //   size: 16,
          //   paddingLeft: 15,
          //   paddingBottom: 5,
          // ),
          // Container(
          //   height: 70,
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     physics: BouncingScrollPhysics(),
          //     itemCount: 10,
          //     padding: EdgeInsets.symmetric(
          //       horizontal: 7.5,
          //     ),
          //     scrollDirection: Axis.horizontal,
          //     itemBuilder: (context, index) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(
          //           horizontal: 7.5,
          //         ),
          //         child: ProfileImage(
          //           imgURL: Assets.imagesDummyMan,
          //           size: 55,
          //         ),
          //       );
          //     },
          //   ),
          // ),
          MyText(
            text: 'Messages',
            size: 16,
            paddingTop: 15,
            paddingLeft: 15,
            paddingBottom: 5,
          ),
          StreamBuilder(
            stream: chatRooms
                .where(
                  'participants.${userDetailModel.uId}',
                  isEqualTo: true,
                )
                .orderBy(
                  'createdAt',
                  descending: true,
                )
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      ChatRoomModel chatRooms = ChatRoomModel.fromJson(
                        snapshot.data!.docs[index].data()
                            as Map<String, dynamic>,
                      );
                      Map<String, dynamic> _participants =
                          chatRooms.participants;
                      List<String> _participantsKey =
                          _participants.keys.toList();
                      _participantsKey.remove(userDetailModel.uId);
                      log(_participantsKey[0].toString());
                      return FutureBuilder(
                        future: profiles.doc(_participantsKey[0]).get(),
                        builder: (context, snapShot) {
                          if (snapShot.hasData) {
                            DocumentSnapshot docSnapShot =
                                snapShot.data as DocumentSnapshot;
                            UserDetailModel tUDM = UserDetailModel.fromJson(
                              docSnapShot.data() as Map<String, dynamic>,
                            );
                            return ChatHeadsTiles(
                              imageURL: tUDM.profileImgUrl!,
                              name: tUDM.fullName!,
                              lastMsg: chatRooms.lastMsg,
                              time: chatRooms.lstMsgTime,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => ChatScreen(
                                    chatRoomModel: chatRooms,
                                    targetedUser: tUDM,
                                  ),
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
