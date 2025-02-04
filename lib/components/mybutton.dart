import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String buttonname;
  final Color color;
  final Icon icon;
  VoidCallback onPressed;

  var primecolor = const Color(0xFF00c7e7);

  MyButton(
      {super.key,
      required this.buttonname,
      required this.color,
      required this.icon,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 145,
      height: 50,
      child: MaterialButton(
       elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
         
        onPressed: onPressed,
        color: color,
        child: Row(
          children: [
            icon,
            SizedBox(width: 5,)
            
             ,Text(buttonname,
          style: GoogleFonts.inter
            //blinker
            (fontWeight: FontWeight.bold, fontSize: 16),
          ),
          ]
        ),
      ),
    );
  }
}
