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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class ChatProvider with ChangeNotifier {
  static ChatProvider instance = ChatProvider();
  TextEditingController sendCon = TextEditingController();
  XFile? pickedImage;
  String pickedImageUrl = '';
  DateTime now = DateTime.now();
  final format = DateFormat('h:mm a');

  Future pickImage(BuildContext context, ImageSource source) async {
    try {
      XFile? _img = await ImagePicker().pickImage(source: source);
      if (_img == null) {
        return;
      } else {
        pickedImage = _img;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      showMsg(
        context,
        'Something is wrong with picking image!',
      );
    }
  }

  // Future uploadImage() async {
  //   Reference ref = await firebaseStorage
  //       .ref()
  //       .child('images/chat Images/${DateTime.now().toString()}');
  //   TaskSnapshot taskSnapshot = await ref.putFile(File(pickedImage!.path));
  //   taskSnapshot.eve
  //   await ref.getDownloadURL().then(
  //     (value) {
  //       pickedImageUrl = value.toString();
  //       notifyListeners();
  //     },
  //   );
  // }

  void sendMsg(
    BuildContext context,
    ChatRoomModel cRM,
  ) async {
    String msg = sendCon.text;
    sendCon.clear();

    if (msg != '') {
      MessageModel mM = MessageModel(
        time: '${format.format(now)}',
        msgId: uuid.v1(),
        msg: msg,
        sender: userDetailModel.uId!,
        mediaType: 'text',
        isSeen: false,
      );
      chatRooms
          .doc(cRM.roomId)
          .collection('messages')
          .doc(mM.msgId)
          .set(mM.toJson());
      cRM.lastMsg = mM.msg;
      cRM.lstMsgTime = mM.time;
      chatRooms.doc(cRM.roomId).set(cRM.toJson());
    } else if (pickedImage != null) {
      MessageModel mMM = MessageModel(
        time: DateTime.now().millisecondsSinceEpoch.toString(),
        msgId: uuid.v1(),
        msg: msg,
        sender: userDetailModel.uId!,
        mediaType: 'image',
        isSeen: false,
      );
      chatRooms
          .doc(cRM.roomId)
          .collection('messages')
          .doc(mMM.msgId)
          .set(mMM.toJson());
    } else {
      showMsg(context, 'Message cannot be empty!');
    }
  }

  Future<ChatRoomModel?> getChatRooms(
    BuildContext context,
    UserDetailModel targetUser,
  ) async {
    ChatRoomModel? chatRoom;
    QuerySnapshot snapshot = await chatRooms
        .where('participants.${userDetailModel.uId}', isEqualTo: true)
        .where('participants.${targetUser.uId}', isEqualTo: true)
        .get();

    if (snapshot.docs.length > 0) {
      var doc = snapshot.docs[0];
      ChatRoomModel existingChatRoom = ChatRoomModel.fromJson(
        doc.data() as Map<String, dynamic>,
      );
      chatRoom = existingChatRoom;
      showMsg(context, 'CHAT ROOM ALREADY CREATED!');
    } else {
      ChatRoomModel newChatRoom = ChatRoomModel(
        createdAt: DateFormat.yMEd().format(DateTime.now()).toString(),
        roomId: uuid.v1(),
        lastMsg: '',
        lstMsgTime: '',
        participants: {
          userDetailModel.uId!: true,
          targetUser.uId!: true,
        },
      );
      await chatRooms.doc(newChatRoom.roomId).set(newChatRoom.toJson());
      chatRoom = newChatRoom;
      showMsg(context, 'CHAT ROOM CREATED!', bgColor: kSuccessColor);
    }
    return chatRoom;
  }

  Future gotoChatScreen(
    BuildContext context,
    UserDetailModel tUDM,
  ) async {
    ChatRoomModel? cRM = await chatProvider.getChatRooms(
      context,
      tUDM,
    );
    if (cRM != null) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) {
          return ChatScreen(
            chatRoomModel: cRM,
            targetedUser: tUDM,
          );
        }),
      );
    }
  }
}
