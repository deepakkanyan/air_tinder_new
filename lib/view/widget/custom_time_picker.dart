import 'package:air_tinder/constant/color.dart';
import 'package:air_tinder/view/widget/my_button.dart';
import 'package:air_tinder/view/widget/my_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTimePicker extends StatelessWidget {
  CustomTimePicker({
    required this.initialDateTime,
    required this.onDateTimeChanged,
    required this.heading,
    required this.onDoneTap,
  });

  final DateTime initialDateTime;
  final ValueChanged<DateTime> onDateTimeChanged;
  final VoidCallback onDoneTap;
  final String heading;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
          child: Container(
            height: 300,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MyText(
                  paddingLeft: 15,
                  paddingTop: 10,
                  text: heading,
                  size: 16,
                  align: TextAlign.center,
                  weight: FontWeight.w600,
                ),
                Expanded(
                  child: CupertinoTheme(
                    data: CupertinoThemeData(
                      textTheme: CupertinoTextThemeData(
                        dateTimePickerTextStyle: TextStyle(
                          fontSize: 14,
                          fontFamily: GoogleFonts.poppins().fontFamily,
                          color: Colors.black,
                        ),
                      ),
                      scaffoldBackgroundColor: Colors.transparent,
                      primaryColor: Colors.red,
                    ),
                    child: CupertinoDatePicker(
                      initialDateTime: initialDateTime,
                      mode: CupertinoDatePickerMode.time,
                      backgroundColor: kPrimaryColor,
                      minimumYear: 1900,
                      maximumYear: DateTime.now().year,
                      onDateTimeChanged: onDateTimeChanged,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: MyButton(
                    onTap: onDoneTap,
                    buttonText: 'Done',
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}