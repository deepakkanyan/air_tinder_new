import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

class PickImage extends StatelessWidget {
  const PickImage({
    Key? key,
    required this.pickFromCamera,
    required this.pickFromGallery,
  }) : super(key: key);
  final VoidCallback pickFromCamera;
  final VoidCallback pickFromGallery;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: kGreyColor.withOpacity(0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              onTap: pickFromCamera,
              leading: Image.asset(
                Assets.imagesCamera,
                color: kSecondaryColor,
                height: 30,
              ),
              title: MyText(
                text: 'Camera',
                size: 18,
              ),
            ),
            ListTile(
              onTap: pickFromGallery,
              leading: Image.asset(
                Assets.imagesGallery,
                height: 30,
                color: kSecondaryColor,
              ),
              title: MyText(
                text: 'Gallery',
                size: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
