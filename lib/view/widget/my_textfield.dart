import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextField extends StatelessWidget {
  MyTextField({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText = '',
    this.labelText = '',
    this.maxLines = 1,
    this.havePrefix = true,
    this.haveLabel = true,
    this.isAllWhite = false,
    this.iconSize,
    this.prefixIcon,
    this.isFilled = false,
    this.isReadOnly = false,
    this.filledColor,
    this.onTap,
  }) : super(key: key);

  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  String? labelText, hintText, prefixIcon;
  double? iconSize;
  int maxLines;
  bool? havePrefix, haveLabel, isAllWhite, isFilled, isReadOnly;
  Color? filledColor;
  VoidCallback? onTap;

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 15,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          haveLabel!
              ? MyText(
                  text: labelText,
                  size: 16,
                  color: isAllWhite! ? kPrimaryColor : kTertiaryColor,
                  paddingBottom: 5,
                )
              : SizedBox(),
          TextFormField(
            textInputAction: TextInputAction.next,
            onTap: onTap,
            readOnly: isReadOnly!,
            maxLines: maxLines,
            controller: controller,
            onChanged: onChanged,
            cursorColor: isAllWhite!
                ? isFilled!
                    ? kSecondaryColor
                    : kPrimaryColor
                : kTertiaryColor,
            cursorWidth: 1.0,
            style: TextStyle(
              fontSize: 16,
              color: isAllWhite!
                  ? isFilled!
                      ? kSecondaryColor
                      : kPrimaryColor
                  : kTertiaryColor,
            ),
            decoration: InputDecoration(
              filled: isFilled,
              fillColor: filledColor,
              prefixIcon: havePrefix!
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          prefixIcon!,
                          height: iconSize,
                          color: isAllWhite! ? kPrimaryColor : kSecondaryColor,
                        ),
                      ],
                    )
                  : null,
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: 16,
                color: isAllWhite!
                    ? isFilled!
                        ? kSecondaryColor
                        : kPrimaryColor
                    : kTertiaryColor,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: maxLines > 1 ? 10 : 0,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isAllWhite! ? kPrimaryColor : kTertiaryColor,
                  width: 1.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: isAllWhite! ? kPrimaryColor : kSecondaryColor,
                  width: 1.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
