
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final ThemeData kAppTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.red,
  primaryColor: Colors.red.shade400,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.red.shade400,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Color.fromRGBO(35, 35, 35, 1.0),
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.red,
    foregroundColor: Color.fromRGBO(35, 35, 35, 1.0),
  )
);

final kCJKTextStyle = TextStyle(
  fontFamily: GoogleFonts.notoSansSc().fontFamily,
  fontFamilyFallback: [
    GoogleFonts.notoSansTc().fontFamily!,
  ],
);

final kUITextStyle = TextStyle(
  fontFamily: GoogleFonts.nunito().fontFamily,
);