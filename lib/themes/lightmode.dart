import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    //primarySwatch: Colors.deepPurple,
    colorScheme: ColorScheme.light(
      primary: Colors.deepPurple.shade300,
      secondary: Colors.deepPurpleAccent.shade700,
      surface: Colors.white,
      inversePrimary: Colors.deepPurple.shade800,
    ),
    textTheme: ThemeData.light()
        .textTheme
        .apply(bodyColor: Colors.grey[800], displayColor: Colors.black));
