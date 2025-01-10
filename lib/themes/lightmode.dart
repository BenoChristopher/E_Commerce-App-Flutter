import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    //primarySwatch: Colors.deepPurple,
    colorScheme: ColorScheme.light(
      primary: const Color(0xFF00c7e7),
      secondary: Colors.blueAccent.shade700,
      surface: Colors.white,
      inversePrimary: Colors.blue.shade800,
    ),
    textTheme: ThemeData.light()
        .textTheme
        .apply(bodyColor: Colors.grey[800], displayColor: Colors.black));
