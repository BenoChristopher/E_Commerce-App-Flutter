import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyProfile extends StatelessWidget {

  final String text;
   MyProfile({super.key,required this.text});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text,
      style: GoogleFonts.blinker(fontWeight: FontWeight.w500,
      color: Colors.grey[700],),
      ),),
    
    );
  }
}







































