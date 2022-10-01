import 'package:air_tinder/constant/color.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileImage extends StatelessWidget {
  ProfileImage({
    Key? key,
    this.size = 38.0,
    this.imgURL,
  }) : super(key: key);

  String? imgURL;
  double? size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: kSecondaryColor,
          width: 1.0,
        ),
        image: DecorationImage(
          image: AssetImage(
            imgURL!,
          ),
        ),
      ),
    );
  }
}