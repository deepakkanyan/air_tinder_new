import 'dart:io';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/model/chat_model/chat_room_model.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/widget/simple_appbar.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class SendImagePreview extends StatelessWidget {
  SendImagePreview({
    required this.file,
    required this.chatRoomModel,
  });

  final XFile file;
  ChatRoomModel chatRoomModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: simpleAppBar(
        context: context,
        title: 'Image Preview',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => chatProvider.sendImage(
          context,
          chatRoomModel,
        ),
        backgroundColor: kPrimaryColor,
        elevation: 5,
        tooltip: 'Send',
        child: Padding(
          padding: const EdgeInsets.only(
            left: 4,
          ),
          child: Icon(
            Icons.send,
            color: kSecondaryColor,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.file(
              File(file.path),
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
