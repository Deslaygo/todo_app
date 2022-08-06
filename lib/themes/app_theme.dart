import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/themes/color_palette.dart';

class AppTheme {
  static ThemeData getAppTheme() {
    return ThemeData(
      backgroundColor: backgroundColor,
      primaryColor: primaryColor,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: backgroundColor,
      ),
      textTheme: TextTheme(
        headline1: GoogleFonts?.inter(
          textStyle: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: titleColor,
          ),
        ),
        headline2: GoogleFonts?.inter(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        bodyText1: GoogleFonts?.inter(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        bodyText2: GoogleFonts?.inter(
          textStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
      ),
    );
  }
}
