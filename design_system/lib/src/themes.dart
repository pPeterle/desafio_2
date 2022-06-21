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
    secondary: Color(0xff1A223A),
    onPrimary: Colors.white,
    primary: Color(0xff262E51),
    onSecondary: Colors.white,
    error: Color(0xffef233c),
    onError: Colors.white,
    background: Color(0xff262E51),
    onBackground: Colors.white,
    surface: Color(0xff262E51),
    onSurface: Color(0xffA1A1A1),
  ),
);
