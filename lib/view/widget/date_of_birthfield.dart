import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/generated/assets.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DateOfBirthField extends StatelessWidget {
  DateOfBirthField({
    Key? key,
    this.controller,
    this.onChanged,
    this.hintText = 'Date of birth',
    this.isAllWhite = false,
    this.onCalenderTap,
  }) : super(key: key);

  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  String? hintText;
  bool? isAllWhite;
  VoidCallback? onCalenderTap;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      cursorColor: isAllWhite! ? kPrimaryColor : kTertiaryColor,
      cursorWidth: 1.0,
      style: TextStyle(
        fontSize: 16,
        color: isAllWhite! ? kPrimaryColor : kTertiaryColor,
      ),
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: onCalenderTap,
              child: Image.asset(
                Assets.imagesCalendarBlack,
                height: 18.78,
                color: isAllWhite! ? kPrimaryColor : kTertiaryColor,
              ),
            ),
          ],
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 16,
          color: isAllWhite! ? kPrimaryColor : kTertiaryColor,
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 15,
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
            color: isAllWhite! ? kPrimaryColor : kTertiaryColor,
            width: 1.0,
          ),
        ),
      ),
    );
  }
}
