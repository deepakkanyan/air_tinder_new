import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:air_tinder/view/widget/height_width.dart';
import 'package:flutter/material.dart';

class SendField extends StatelessWidget {
  SendField({
    Key? key,
    this.dateType,
    this.controller,
    this.onChanged,
    this.validator,
    this.onSendTap,
    this.onImagePick,
  }) : super(key: key);

  String? dateType;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  FormFieldValidator<String>? validator;
  VoidCallback? onSendTap;
  VoidCallback? onImagePick;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 100,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Container(
                height: 80,
                padding: const EdgeInsets.only(
                  left: 15,
                  right: 15,
                  bottom: 10,
                ),
                width: width(1.0, context),
                decoration: BoxDecoration(
                  color: kBrownColor,
                  border: Border(
                    top: BorderSide(
                      width: 1,
                      color: kSecondaryColor,
                    ),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: kPrimaryColor,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: TextFormField(
                            onChanged: onChanged,
                            controller: controller,
                            validator: validator,
                            cursorColor: kSecondaryColor,
                            style: TextStyle(
                              fontSize: 16,
                              color: kTertiaryColor,
                            ),
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 15,
                              ),
                              hintText: 'Type here...',
                              hintStyle: TextStyle(
                                fontSize: 16,
                                color: kTertiaryColor.withOpacity(0.70),
                              ),
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              errorBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: onImagePick,
                      child: Image.asset(
                        Assets.imagesPickImage,
                        height: 48,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    GestureDetector(
                      onTap: onSendTap,
                      child: Image.asset(
                        Assets.imagesSendButton,
                        height: 48,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20,
              child: Container(
                height: 10,
                width: width(1.0, context),
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
