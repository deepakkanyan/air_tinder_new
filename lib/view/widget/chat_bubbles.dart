import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ChatBubbles extends StatelessWidget {
  ChatBubbles({
    Key? key,
    required this.msg,
    required this.senderType,
    required this.time,
    required this.msgID,
  }) : super(key: key);
  String msg, senderType, time, msgID;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Align(
        alignment: senderType == 'me' ? Alignment.topRight : Alignment.topLeft,
        child: Column(
          crossAxisAlignment: senderType == 'me'
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            Container(
              margin: EdgeInsets.only(
                right: senderType == 'me' ? 0 : 60,
                left: senderType == 'me' ? 60 : 0,
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 5,
              ),
              decoration: BoxDecoration(
                color: senderType == 'me' ? kBrownColor : kSecondaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(5),
                  bottomLeft: Radius.circular(senderType == 'me' ? 5 : 0),
                  bottomRight: Radius.circular(senderType == 'me' ? 0 : 5),
                ),
              ),
              child: MyText(
                text: '$msg',
                size: 14,
                color: kPrimaryColor,
              ),
            ),
            MyText(
              paddingTop: 5,
              text: time,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
