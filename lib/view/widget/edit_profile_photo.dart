import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:flutter/material.dart';

class EditProfilePhoto extends StatelessWidget {
  EditProfilePhoto({
    Key? key,
    this.profileImage,
    this.onEditTap,
  }) : super(key: key);
  VoidCallback? onEditTap;
  String? profileImage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          Container(
            height: 160,
            width: 160,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                width: 1.0,
                color: kSecondaryColor,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                profileImage!,
                height: height(1.0, context),
                width: width(1.0, context),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 22,
            right: 18,
            child: GestureDetector(
              onTap: onEditTap,
              child: Image.asset(
                Assets.imagesAddPhotoWhite,
                height: 26,
              ),
            ),
          ),
        ],
      ),
    );
  }
}