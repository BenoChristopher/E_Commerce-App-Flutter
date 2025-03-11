import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {

  final String text;
   MyProfile({super.key,required this.text});
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(text)),
    
    );
  }
}







































