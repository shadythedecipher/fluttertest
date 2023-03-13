 import 'package:flutter/material.dart';
 import 'package:google_fonts/google_fonts.dart';

class GlobalVariables{
  static const backgroundColor = Colors.white;
  static const Color blackColor = Color(0xff020202);
  static const Color backgroundTextColor = Color(0xffeff8f8);
  static const Color callToAction = Color(0xffffd642);
  static const Color buttonColor = Color(0xfffebf00);
  static const Color retryAction = Color(0xff0c35ff);
  static const Color error = Color(0xedfd0303);
  static const Color otp = Color(0xffcdced1);

  static ThemeData myTheme = ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 18,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 12,
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 10,
          )
      )
  );
  static ThemeData myTheme2 = ThemeData(
      useMaterial3: true,
      textTheme: TextTheme(
          displayLarge: GoogleFonts.poppins(
            fontSize: 16,
            color: Colors.red
          ),
          displayMedium: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          displaySmall: GoogleFonts.poppins(
            fontSize: 14,
          ),
          bodyLarge: GoogleFonts.poppins(
            fontSize: 14,
            color: buttonColor,
              fontWeight: FontWeight.bold,
          ),
          bodyMedium: GoogleFonts.poppins(
            fontSize: 28,
            color: blackColor
          ),
          bodySmall: GoogleFonts.poppins(
            fontSize: 10,
          )
      )
  );
}