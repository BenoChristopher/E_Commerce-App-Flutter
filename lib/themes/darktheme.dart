import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: Colors.deepPurple.shade300,
      secondary: Colors.deepPurpleAccent.shade700,
      surface: Colors.grey.shade900,
      inversePrimary: Colors.deepPurple.shade800,
    ),
    textTheme: ThemeData.light()
        .textTheme
        .apply(bodyColor: Colors.grey[200], displayColor: Colors.white));
