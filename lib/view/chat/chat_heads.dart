import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/black_logo_app_bar.dart';
import 'package:air_tinder/view/widget/chat_head_tiles.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:air_tinder/view/widget/profile_image.dart';
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
          MyText(
            text: 'New matches',
            size: 16,
            paddingLeft: 15,
            paddingBottom: 5,
          ),
          Container(
            height: 70,
            child: ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: 10,
              padding: EdgeInsets.symmetric(
                horizontal: 7.5,
              ),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7.5,
                  ),
                  child: ProfileImage(
                    imgURL: Assets.imagesDummyMan,
                    size: 55,
                  ),
                );
              },
            ),
          ),
          MyText(
            text: 'Messages',
            size: 16,
            paddingTop: 15,
            paddingLeft: 15,
            paddingBottom: 5,
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {
              return ChatHeadsTiles(
                imageURL: Assets.imagesDummyMan,
                name: 'Marilyn Porter',
                lastMsg: 'Looking forward to see you.',
                time: '8:00 PM',
              );
            },
          ),
        ],
      ),
    );
  }
}
