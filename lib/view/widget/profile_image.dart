import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ProfileImage extends StatelessWidget {
  ProfileImage({Key? key, this.size = 38.0, required this.imgURL, this.loadingColor}) : super(key: key);

  final String imgURL;
  double? size;
  Color? loadingColor;

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
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          imgURL,
          width: size,
          height: size,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(Assets.imagesUser);
          },
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return loadingWidget(context, size: 30, color: loadingColor ?? kSecondaryColor);
          },
        ),
      ),
    );
  }
}
