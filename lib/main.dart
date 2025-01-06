import 'package:flutter/material.dart';
import 'package:mca_project/themes/lightmode.dart';

import 'pages/loginpage.dart';
import 'pages/welcomepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MyWelComePage(),
        theme: lightMode);
  }
}
