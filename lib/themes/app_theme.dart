import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData getAppTheme() {
    return ThemeData(
      backgroundColor: Colors.white,
      textTheme: TextTheme(
        headline1: GoogleFonts?.inter(
          textStyle: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.w700,
            color: Color(0XFF292B35),
          ),
        ),
        headline2: GoogleFonts?.inter(
          textStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0XFF575767),
          ),
        ),
        bodyText1: GoogleFonts?.inter(
          textStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0XFF575767),
          ),
        ),
      ),
    );
  }
}
