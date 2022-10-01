import 'package:air_tinder/constant/color.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  scaffoldBackgroundColor: kPrimaryColor,
  fontFamily: GoogleFonts.poppins().fontFamily,
  appBarTheme: AppBarTheme(
    color: kPrimaryColor,
    elevation: 0,
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: kSecondaryColor,
  ),
  colorScheme: ColorScheme.fromSwatch().copyWith(
    secondary: kSecondaryColor.withOpacity(0.1),
  ),
);
