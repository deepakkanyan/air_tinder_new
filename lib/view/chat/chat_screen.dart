import 'dart:developer';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/model/chat_model/chat_room_model.dart';
import 'package:air_tinder/model/chat_model/message_model.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/widget/block_user_button.dart';
import 'package:air_tinder/view/widget/chat_bubbles.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/pick_image.dart';
import 'package:air_tinder/view/widget/profile_image.dart';
import 'package:air_tinder/view/widget/send_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({required this.chatHeadModel, required this.otherUserModel});

  final ChatRoomModel chatHeadModel;
  final UserDetailModel otherUserModel;

  @override
  Widget build(BuildContext context) {
    log(" chatHeadModel.isBlockById : ${chatHeadModel.isBlockById}");
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        elevation: 4,
        leadingWidth: 30,
        leading: Column(
          children: [
            IconButton(
              padding: EdgeInsets.only(left: 15),
              onPressed: () => Navigator.pop(context),
              icon: Image.asset(Assets.imagesArrowBack, height: 15.87),
            ),
          ],
        ),
        title: Row(
          children: [
            ProfileImage(size: 45.0, imgURL: otherUserModel.profileImgUrl!),
            Expanded(
              child: MyText(
                paddingLeft: 15,
                text: otherUserModel.fullName,
                size: 16,
              ),
            ),
          ],
        ),
        actions: [
          // BlockUserButton(
          //   cRM: chatHeadModel,
          //   targetUser: otherUserModel,
          // ),
          chatHeadModel.isBlockById == ""
              ? Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: PopupMenuButton<int>(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.report_outlined),
                            SizedBox(width: 10),
                            Text("Report User"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(Icons.block),
                            SizedBox(width: 10),
                            Text("Block User"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 3,
                        child: Row(
                          children: [
                            Icon(Icons.block),
                            SizedBox(width: 10),
                            Text("Report & Block"),
                          ],
                        ),
                      ),
                    ],
                    offset: Offset(0, 100),
                    color: Colors.grey,
                    elevation: 2,
                    onSelected: (value) async {
                      if (value == 1) {
                        await fireStore.collection('ReportedUserCount').doc(otherUserModel.uId).set({
                          "reportedUserId": otherUserModel.uId ?? "",
                          "reportedByIds": FieldValue.arrayUnion(
                            [
                              auth.currentUser!.uid,
                            ],
                          ),
                          "userReportCount": FieldValue.increment(1),
                        }, SetOptions(merge: true));
                        await fireStore.collection('ReportedUserCount').doc(otherUserModel.uId).get().then((value) async {
                          if (value.exists) {
                            if (value['userReportCount'] > 3) {
                              log("value['userReportCount'] ${value['userReportCount']}");
                              await fireStore.collection('DeactivatedAccount').doc(otherUserModel.uId).set({
                                'name': userDetailModel.fullName,
                                'uid': userDetailModel.uId,
                                'email': userDetailModel.email,
                                'photo': userDetailModel.additionalImages,
                                'gender': userDetailModel.gender,
                              }, SetOptions(merge: true));
                            } else {
                              //
                            }
                          } else {
                            //
                          }
                        });
                      } else if (value == 2) {
                        await FirebaseFirestore.instance.collection('ChatRooms').doc(chatHeadModel.roomId).update(
                          {
                            'isBlockById': userDetailModel.uId!,
                            'isBlockByName': userDetailModel.fullName!,
                          },
                        );
                        Navigator.of(context).pop();
                        showMsg(context, 'User blocked !', bgColor: kSuccessColor);
                      } else if (value == 3) {
                        await fireStore.collection('ReportedUserCount').doc(otherUserModel.uId).set({
                          "reportedUserId": otherUserModel.uId ?? "",
                          "reportedByIds": FieldValue.arrayUnion(
                            [
                              auth.currentUser!.uid,
                            ],
                          ),
                          "userReportCount": FieldValue.increment(1),
                        }, SetOptions(merge: true));

                        await FirebaseFirestore.instance.collection('ChatRooms').doc(chatHeadModel.roomId).update(
                          {
                            'isBlockById': userDetailModel.uId!,
                            'isBlockByName': userDetailModel.fullName!,
                          },
                        );
                        await fireStore.collection('ReportedUserCount').doc(otherUserModel.uId).get().then((value) async {
                          if (value.exists) {
                            if (value['userReportCount'] > 3) {
                              log("value['userReportCount'] ${value['userReportCount']}");
                              await fireStore.collection('DeactivatedAccount').doc(otherUserModel.uId).set({
                                'name': userDetailModel.fullName,
                                'uid': userDetailModel.uId,
                                'email': userDetailModel.email,
                                'photo': userDetailModel.additionalImages,
                                'gender': userDetailModel.gender,
                              }, SetOptions(merge: true));
                            } else {
                              //
                            }
                          } else {
                            //
                          }
                        });

                        Navigator.of(context).pop();
                        showMsg(context, 'User blocked & reported successfully !', bgColor: kSuccessColor);
                      }
                    },
                  ),
                )
              : Theme(
                  data: Theme.of(context).copyWith(
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                  ),
                  child: PopupMenuButton<int>(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.report_outlined),
                            SizedBox(width: 10),
                            Text("Unblock User"),
                          ],
                        ),
                      ),
                      // PopupMenuItem 2
                    ],
                    offset: Offset(0, 100),
                    color: Colors.grey,
                    elevation: 2,
                    onSelected: (value) async {
                      if (value == 1) {
                        await FirebaseFirestore.instance.collection('ChatRooms').doc(chatHeadModel.roomId).update(
                          {
                            'isBlockById': "",
                            'isBlockByName': "",
                          },
                        );
                        Navigator.of(context).pop();
                        showMsg(context, 'User Unblocked !', bgColor: kSuccessColor);
                      }
                      // else if (value == 2) {
                      //   log("Block this User");
                      //   await FirebaseFirestore.instance.collection('ChatRooms').doc(chatHeadModel.roomId).update(
                      //     {
                      //       'isBlockById': userDetailModel.uId!,
                      //       'isBlockByName': userDetailModel.fullName!,
                      //     },
                      //   );
                      //   Navigator.of(context).pop();
                      //   showMsg(context, 'User blocked !', bgColor: kSuccessColor);
                      // }
                    },
                  ),
                ),
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: chatRooms.doc(chatHeadModel.roomId).collection('messages').orderBy('time', descending: true).snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    reverse: true,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(
                      left: 15,
                      right: 15,
                      bottom: 100,
                      top: 30,
                    ),
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      MessageModel mM = MessageModel.fromJson(
                        data.data() as Map<String, dynamic>,
                      );
                      return ChatBubbles(
                        msgID: mM.msgId,
                        senderType: mM.sender == userDetailModel.uId ? 'me' : 'other',
                        msg: mM.msg,
                        time: mM.time,
                        mediaType: mM.mediaType,
                      );
                    },
                  );
                } else if (snapshot.hasError) {
                  showMsg(context, 'Something went wrong!');
                  return loadingWidget(context);
                } else {
                  return Container();
                }
              } else {
                return loadingWidget(context);
              }
            },
          ),
          chatHeadModel.isBlockById == ""
              ? SendField(
                  dateType: 'planned',
                  controller: chatProvider.sendCon,
                  onImagePick: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return PickImage(
                          pickFromCamera: () => chatProvider.pickImage(
                            context,
                            ImageSource.camera,
                            chatHeadModel,
                          ),
                          pickFromGallery: () => chatProvider.pickImage(
                            context,
                            ImageSource.gallery,
                            chatHeadModel,
                          ),
                        );
                      },
                      isScrollControlled: true,
                    );
                  },
                  onSendTap: () => chatProvider.sendTextMsg(context, chatHeadModel, otherUserModel),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
