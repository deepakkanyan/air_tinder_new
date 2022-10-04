import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/widget/block_user_button.dart';
import 'package:air_tinder/view/widget/chat_bubbles.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/profile_image.dart';
import 'package:air_tinder/view/widget/send_field.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  ChatScreen({
    this.profileImage,
    this.name,
  });

  String? profileImage, name;

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
              imgURL: userDetailModel.profileImgUrl!,
            ),
            Expanded(
              child: MyText(
                paddingLeft: 15,
                text: name,
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
          ListView.builder(
            physics: BouncingScrollPhysics(),
            reverse: true,
            itemCount: 2,
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(
              horizontal: 15,
              vertical: 30,
            ),
            itemBuilder: (context, index) {
              return ChatBubbles(
                msg: index.isEven
                    ? 'Yes! I can\'t wait to see you.'
                    : 'Hi. We will be at the same layover. How exciting is this.',
                senderType: index.isEven ? 'me' : 'other',
              );
            },
          ),
          SendField(
            // dateType: widget.dateType,
            dateType: 'planned',
            onSendTap: () {},
          ),
        ],
      ),
    );
  }
}
