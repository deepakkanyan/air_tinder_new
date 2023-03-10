import 'dart:developer';
import 'dart:io';
import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/main.dart';
import 'package:air_tinder/model/chat_model/chat_room_model.dart';
import 'package:air_tinder/model/chat_model/message_model.dart';
import 'package:air_tinder/model/user_detail_model/user_detail_model.dart';
import 'package:air_tinder/utils/collections.dart';
import 'package:air_tinder/utils/custom_flush_bar.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/chat/chat_screen.dart';
import 'package:air_tinder/view/chat/send_image_preview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatProvider {
  static ChatProvider instance = ChatProvider();
  TextEditingController sendCon = TextEditingController();
  XFile? pickedImage;
  final format = DateFormat('h:mm a');

  Future blockUser(BuildContext context, ChatRoomModel cRM, UserDetailModel targetUser) async {
    try {
      Navigator.pop(context);
      await chatRooms.doc(cRM.roomId).update(
        {
          'participants': {
            targetUser.uId: false,
            userDetailModel.uId: true,
          },
        },
      );
      showMsg(
        context,
        'User blocked!',
        bgColor: kSuccessColor,
      );
    } on FirebaseException catch (e) {
      showMsg(
        context,
        e.message.toString(),
      );
    }
  }

  Future pickImage(BuildContext context, ImageSource source, ChatRoomModel cRM) async {
    try {
      XFile? _img = await ImagePicker().pickImage(source: source, imageQuality: imageQuality);
      if (_img == null) {
        return;
      } else {
        pickedImage = _img;
      }
      Navigator.pop(context);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => SendImagePreview(
            file: pickedImage!,
            chatRoomModel: cRM,
          ),
        ),
      );
    } on PlatformException catch (e) {
      showMsg(
        context,
        'Something is wrong with picking image!',
      );
    }
  }

  Future sendImage(BuildContext context, ChatRoomModel cRM) async {
    Navigator.pop(context);
    Reference ref = await firebaseStorage.ref().child('images/chat Images/${DateTime.now().toString()}');
    await ref.putFile(File(pickedImage!.path));
    await ref.getDownloadURL().then(
      (value) async {
        MessageModel mMM = MessageModel(
          time: '${format.format(DateTime.now())}',
          msgId: uuid.v1(),
          msg: value.toString(),
          sender: userDetailModel.uId!,
          mediaType: 'image',
          isSeen: false,
        );
        chatRooms.doc(cRM.roomId).collection('messages').doc(mMM.msgId).set(mMM.toJson());
        cRM.lastMsg = mMM.msg;
        cRM.lstMsgTime = mMM.time;
        chatRooms.doc(cRM.roomId).set(cRM.toJson());
        pickedImage = null;
      },
    );
  }

  void sendTextMsg(BuildContext context, ChatRoomModel cRM, UserDetailModel? otherUserModel) async {
    log("current user id : ${auth.currentUser!.uid}");
    log("other user id : ${otherUserModel!.uId}");
    // await profiles.doc(otherUserModel.uId).get().then((value) {
    //   print(" .then((value)");
    //   if (value.exists) {
    //     log(" \n  value.exists ${value.data()}  \n");
    //
    //     if (value['blockByIds'].asMap().containsValue(auth.currentUser!.uid)) {
    //       showMsg(context, 'You block this user cannot send msg', bgColor: kSuccessColor);
    //     } else {
    //       showMsg(context, 'You  can  send msg', bgColor: kSuccessColor);
    //     }
    //   } else {
    //     print("value not exist ");
    //   }
    // });
    String msg = sendCon.text;
    sendCon.clear();

    if (msg != '') {
      MessageModel mM = MessageModel(
        time: '${format.format(DateTime.now())}',
        msgId: uuid.v1(),
        msg: msg,
        sender: userDetailModel.uId!,
        mediaType: 'text',
        isSeen: false,
      );
      await FirebaseFirestore.instance
          .collection('ChatRooms')
          .doc(cRM.roomId)
          .collection('messages')
          .doc(mM.msgId)
          .set(mM.toJson());
      cRM.lastMsg = mM.msg;
      cRM.lstMsgTime = mM.time;
      chatRooms.doc(cRM.roomId).set(cRM.toJson());
    } else {
      showMsg(context, 'Message cannot be empty!');
    }
  }

  Future<ChatRoomModel?> getChatRooms(BuildContext context, UserDetailModel targetUser, String likesDocId) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await fireStore.collection('ChatRooms').where(
      'participants',
      isEqualTo: [
        userDetailModel.uId,
        targetUser.uId,
      ],
    ).get();

    if (snapshot.docs.length == 0) {
      snapshot = await fireStore.collection('ChatRooms').where(
        'participants',
        isEqualTo: [
          targetUser.uId,
          userDetailModel.uId,
        ],
      ).get();
    }

    if (snapshot.docs.length > 0) {
      var doc = snapshot.docs[0];
      ChatRoomModel existingChatRoom = ChatRoomModel.fromJson(doc.data() as Map<String, dynamic>);
      chatRoom = existingChatRoom;
      showMsg(context, 'CHAT ROOM ALREADY CREATED!');
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
        createdAt: DateFormat.yMEd().format(DateTime.now()).toString(),
        roomId: uuid.v1(),
        lastMsg: '',
        lstMsgTime: '',
        participants: [
          userDetailModel.uId!,
          targetUser.uId!,
        ],
        isBlockById: "",
        isBlockByName: '',
      );
      await chatRooms.doc(newChatRoom.roomId).set(newChatRoom.toJson());
      await likes.doc(likesDocId).update({'chatInitiated': true});
      chatRoom = newChatRoom;
      showMsg(context, 'CHAT ROOM CREATED!', bgColor: kSuccessColor);
    }
    return chatRoom;
  }

  Future gotoChatScreen(BuildContext context, UserDetailModel tUDM, String likesDocId) async {
    ChatRoomModel? cRM = await chatProvider.getChatRooms(context, tUDM, likesDocId);
    if (cRM != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) {
          return ChatScreen(
            chatHeadModel: cRM,
            otherUserModel: tUDM,
          );
        }),
      );
    }
  }
}
