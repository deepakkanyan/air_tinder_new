import 'package:air_tinder/constant/color.dart';
import 'package:flutter/material.dart';

class ElevatedImage extends StatelessWidget {
  ElevatedImage({
    Key? key,
    this.image,
    this.onTap,
  }) : super(key: key);
  String? image;
  VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: kTertiaryColor.withOpacity(0.16),
                offset: Offset(0, 3),
              ),
            ],
            image: DecorationImage(
              image: AssetImage(image!),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}