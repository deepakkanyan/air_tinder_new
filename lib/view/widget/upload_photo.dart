import 'dart:io';

import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/utils/loading.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhoto extends StatelessWidget {
  UploadPhoto({
    Key? key,
    required this.index,
    this.onTap,
    this.pickedImage,
    this.onRemoveTap,
    this.imgURL,
  }) : super(key: key);

  int index;
  VoidCallback? onTap;
  VoidCallback? onRemoveTap;
  XFile? pickedImage;
  String? imgURL;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            margin: EdgeInsets.only(
              left: index == 0 ? 4.5 : 4.5,
              right: index == 2 ? 4.5 : 4.5,
            ),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: kPrimaryColor,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onTap,
                splashColor: kSecondaryColor.withOpacity(0.05),
                highlightColor: kSecondaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(5),
                child: Center(
                  child: imgURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            imgURL!,
                            height: height(1.0, context),
                            width: width(1.0, context),
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return loadingWidget(context);
                            },
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              }
                              return loadingWidget(context);
                            },
                          ),
                        )
                      : pickedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Image.file(
                                File(pickedImage!.path),
                                height: height(1.0, context),
                                width: width(1.0, context),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Image.asset(
                              Assets.imagesAddImage,
                              height: 35,
                              color: kSecondaryColor,
                            ),
                ),
              ),
            ),
          ),
          (imgURL != null || pickedImage != null)
              ? Positioned(
                  top: 5,
                  right: 10,
                  child: GestureDetector(
                    onTap: onRemoveTap,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kSecondaryColor,
                      ),
                      child: Icon(
                        Icons.close,
                        color: kPrimaryColor,
                        size: 18,
                      ),
                    ),
                  ),
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
