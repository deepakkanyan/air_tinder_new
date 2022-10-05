import 'dart:io';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:flutter/material.dart';

class EditProfilePhoto extends StatelessWidget {
  EditProfilePhoto({
    Key? key,
    this.profileImageURL,
    this.filePath,
    this.onEditTap,
  }) : super(key: key);
  VoidCallback? onEditTap;
  String? profileImageURL;
  File? filePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          _buildImage(context),
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

  Widget _buildImage(BuildContext context) {
    if (profileImageURL != null && profileImageURL!.isNotEmpty) {
      return Container(
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
          child: Image.network(
            profileImageURL!,
            height: height(1.0, context),
            width: width(1.0, context),
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return loadingWidget(
                context,
                size: 30,
                color: kPrimaryColor,
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return loadingWidget(
                context,
                size: 30,
                color: kPrimaryColor,
              );
            },
          ),
        ),
      );
    } else if (filePath != null && filePath!.path.isNotEmpty) {
      return Container(
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
          child: Image.file(
            File(filePath!.path),
            height: height(1.0, context),
            width: width(1.0, context),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
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
            Assets.imagesUser,
            height: height(1.0, context),
            width: width(1.0, context),
            fit: BoxFit.cover,
            color: kPrimaryColor,
          ),
        ),
      );
    }
  }
}
