import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/utils/loading.dart';
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
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image!,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return loadingWidget(context);
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return loadingWidget(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
