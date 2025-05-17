import 'package:flutter/material.dart';

const COLOR_PRIMARY = Color.fromARGB(210, 100, 1, 1);
const COLOR_SECONDARY = Color.fromARGB(255, 255, 255, 255);
const COLOR_TERTIARY = Color.fromARGB(255, 0, 0, 0);
const COLOR_ACCENT = Color.fromARGB(255, 44, 44, 44);
const COLOR_BACKGROUND = Color.fromARGB(255, 216, 216, 216);

ThemeData defaultTheme = ThemeData(
  primaryColor: COLOR_PRIMARY,
  scaffoldBackgroundColor: COLOR_BACKGROUND,
  navigationBarTheme: NavigationBarThemeData(
    ///////not working currently
    backgroundColor: COLOR_PRIMARY,
    indicatorColor: COLOR_SECONDARY,
    iconTheme: WidgetStateProperty.all(
      IconThemeData(color: COLOR_PRIMARY, size: 30),
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: COLOR_PRIMARY,
    titleTextStyle: TextStyle(
      color: COLOR_SECONDARY,
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(color: COLOR_SECONDARY, size: 40),
  ),
  textTheme: TextTheme(
    bodyLarge: TextStyle(
      color: COLOR_TERTIARY,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(color: COLOR_ACCENT, fontSize: 16),

    titleLarge: TextStyle(
      color: const Color.fromARGB(255, 255, 255, 255),
      fontSize: 22,
      fontWeight: FontWeight.bold,
    ),
    titleMedium: TextStyle(
      color: const Color.fromARGB(255, 228, 228, 228),
      fontSize: 12,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: COLOR_PRIMARY,
      foregroundColor: COLOR_SECONDARY,
      textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: COLOR_SECONDARY,
      textStyle: TextStyle(fontSize: 14, color: COLOR_SECONDARY),
      backgroundColor: COLOR_PRIMARY,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: COLOR_PRIMARY,
      side: BorderSide(color: COLOR_PRIMARY),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
    ),
  ),
);
