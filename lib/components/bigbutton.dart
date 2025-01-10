import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyBigButton extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  const MyBigButton({super.key, required this.text, required this.color, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 40),
      
      color: color,
      child: Text(
        text,
        style: GoogleFonts.blinker(fontWeight: FontWeight.bold, fontSize: 16),));
  }
} 
