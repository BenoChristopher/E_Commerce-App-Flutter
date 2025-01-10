import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String buttonname;
  final Color color;
  VoidCallback onPressed;

  var primecolor = const Color(0xFF00c7e7);

  MyButton(
      {super.key,
      required this.buttonname,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
      onPressed: onPressed,
      color: color,
      child: Text(
        buttonname,
        style: GoogleFonts.blinker(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }
}
