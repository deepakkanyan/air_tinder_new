import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/profile_image.dart';
import 'package:flutter/material.dart';

class ChatHeadsTiles extends StatelessWidget {
  ChatHeadsTiles({
    Key? key,
    required this.imageURL,
    required this.name,
    required this.lastMsg,
    required this.time,
    required this.onTap,
  }) : super(key: key);
  String imageURL, name, lastMsg, time;
  VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
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
