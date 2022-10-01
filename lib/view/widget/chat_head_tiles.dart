import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/chat/chat_screen.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/profile_image.dart';
import 'package:flutter/material.dart';

class ChatHeadsTiles extends StatelessWidget {
  ChatHeadsTiles({
    Key? key,
    this.imageURL,
    this.name,
    this.lastMsg,
    this.time,
  }) : super(key: key);
  String? imageURL, name, lastMsg, time;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => ChatScreen(
            profileImage: imageURL,
            name: name,
          ),
        ),
      ),
      leading: ProfileImage(
        size: 50.0,
        imgURL: imageURL,
      ),
      title: MyText(
        text: '$name',
        size: 16,
      ),
      subtitle: MyText(
        text: '$lastMsg',
        size: 14,
        color: kTertiaryColor.withOpacity(0.70),
        weight: FontWeight.w500,
      ),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          MyText(
            text: '$time',
            size: 14,
            color: kTertiaryColor.withOpacity(0.70),
          ),
        ],
      ),
    );
  }
}
