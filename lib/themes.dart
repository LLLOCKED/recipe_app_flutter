import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: GoogleFonts.josefinSansTextTheme().copyWith(
      displayLarge: GoogleFonts.josefinSans(
          fontSize: 24.sp, fontWeight: FontWeight.bold, color: Colors.white),
      displaySmall: GoogleFonts.josefinSans(
          fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.white),
      bodyLarge:
          GoogleFonts.josefinSans(fontSize: 18.sp, color: Colors.black87),
      titleMedium: GoogleFonts.josefinSans(
          fontSize: 16.sp, color: const Color.fromARGB(221, 130, 130, 130)),
    ),
    colorScheme: const ColorScheme.light(
        background: Color.fromARGB(255, 240, 246, 254),
        primary: Color.fromARGB(255, 21, 29, 41),
        secondary: Color.fromARGB(255, 40, 47, 58)));

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme:
        const ColorScheme.dark(background: Color.fromARGB(255, 26, 37, 52)));
