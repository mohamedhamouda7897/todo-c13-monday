import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_c13_monday/theme/base_theme.dart';

class LightTheme extends BaseTheme {
  @override
  Color get background => Color(0xFFF2FEFF);

  @override
  Color get primaryColor => Color(0xFF5669FF);

  @override
  Color get textColor => Color(0xFF1C1C1C);

  @override
  ThemeData get themeData => ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: background,
        appBarTheme: AppBarTheme(
          backgroundColor: background,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: primaryColor,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: primaryColor,
          selectedItemColor: Colors.white,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          showSelectedLabels: true,
        ),
        textTheme: TextTheme(
          titleSmall: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          titleMedium: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
          titleLarge: GoogleFonts.inter(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: textColor,
          ),
        ),
      );
}
