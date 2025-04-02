import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyButton extends StatelessWidget {
  final String buttonname;
  final Color color;
  final Color textcolor;
  final Icon icon;
  final Color iconcolor;
  VoidCallback onPressed;

  var primecolor = const Color(0xFF00c7e7);

  MyButton(
      {super.key,
      required this.textcolor,
      required this.buttonname,
      required this.color,
      required this.icon,
      required this.iconcolor,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.8,
      height: 50,
      child: MaterialButton(
       elevation: 10,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 12),
         
        onPressed: onPressed,
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Icon(icon.icon,color: iconcolor,size: 24,),
            SizedBox(width: 5,)
            
             ,Text(buttonname,
          style: GoogleFonts.blinker
          
            //blinker
            (fontWeight: FontWeight.bold, fontSize: 16,color: textcolor),
          ),
          ]
        ),
      ),
    );
  }
}
