import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/utils/instances.dart';
import 'package:air_tinder/view/widget/profile_image.dart';
import 'package:flutter/material.dart';

class BlackLogoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const BlackLogoAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kPrimaryColor,
      centerTitle: true,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 5,
            ),
            child: ProfileImage(
              imgURL: userDetailModel.profileImgUrl!,
            ),
          ),
        ],
      ),
      title: Image.asset(
        Assets.imagesLogoBlack,
        height: 55.65,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 15,
          ),
          child: Center(
            child: Image.asset(
              Assets.imagesDrawer,
              height: 18.00,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
