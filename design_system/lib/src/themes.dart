import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff306060),
    onPrimary: Colors.white,
    secondary: Color(0xff306060),
    onSecondary: Color(0xff87B2B2),
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color(0xffEDEDED),
    onBackground: Color(0xff616161),
    surface: Colors.white,
    onSurface: Color(0xff616161),
  ),
);

final darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: const ColorScheme(
    brightness: Brightness.dark,
    secondary: Color(0xff29B9F0),
    onPrimary: Colors.white,
    primary: Color(0xff2F71E8),
    onSecondary: Colors.white,
    error: Color(0xffef233c),
    onError: Colors.white,
    background: Color(0xff111213),
    onBackground: Colors.white,
    surface: Color(0xff212224),
    onSurface: Color(0xffA1A1A1),
  ),
);
