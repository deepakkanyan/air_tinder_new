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
import 'package:air_tinder/view/widget/profile_image.dart';
import 'package:air_tinder/view/widget/send_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    required this.chatRoomModel,
    required this.targetedUser,
  });

  final ChatRoomModel chatRoomModel;
  final UserDetailModel targetedUser;

  @override
  Widget build(BuildContext context) {
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
              icon: Image.asset(
                Assets.imagesArrowBack,
                height: 15.87,
              ),
            ),
          ],
        ),
        title: Row(
          children: [
            ProfileImage(
              size: 45.0,
              imgURL: targetedUser.profileImgUrl!,
            ),
            Expanded(
              child: MyText(
                paddingLeft: 15,
                text: targetedUser.fullName,
                size: 16,
              ),
            ),
          ],
        ),
        actions: [
          BlockUserButton(),
        ],
      ),
      body: Stack(
        children: [
          StreamBuilder(
            stream: chatRooms
                .doc(chatRoomModel.roomId)
                .collection('messages').orderBy('time',descending: true)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    reverse: true,
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 30,
                    ),
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      MessageModel mM = MessageModel.fromJson(
                        data.data() as Map<String, dynamic>,
                      );
                      return ChatBubbles(
                        msgID: mM.msgId,
                        senderType:
                            mM.sender == userDetailModel.uId ? 'me' : 'other',
                        msg: mM.msg,
                        time: mM.time,
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
          SendField(
            dateType: 'planned',
            controller: chatProvider.sendCon,
            onSendTap: () => chatProvider.sendMsg(
              context,
              chatRoomModel,
            ),
          ),
        ],
      ),
    );
  }
}
