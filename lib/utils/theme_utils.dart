import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData lightTheme =
      ThemeData(useMaterial3: true, colorSchemeSeed: Colors.grey);

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      secondary: Colors.grey,
      brightness: Brightness.dark,
    ),
  );
}
