
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const kBackgroundColor = Color.fromRGBO(35, 35, 35, 1.0);

final ThemeData kAppTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.red,
  primaryColor: Colors.red.shade500,
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.red.shade500,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: kBackgroundColor,
  appBarTheme: const AppBarTheme(
    backgroundColor: Colors.red,
    foregroundColor: kBackgroundColor,
  )
);

final kCJKTextStyle = GoogleFonts.notoSansSc().copyWith(
  fontFamilyFallback: [
    GoogleFonts.notoSansTc().fontFamily!,
  ],
  color: Colors.white
);

final kUITextStyle = GoogleFonts.nunito();