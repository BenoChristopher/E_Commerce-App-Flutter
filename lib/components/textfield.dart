import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.hintText,
    required this.obsecurText,
    required this.controller,
    required this.icon,
  });

  final String hintText;
  final bool obsecurText;
  final TextEditingController controller;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: controller,
        obscureText: obsecurText,
        decoration: InputDecoration(
          hintText: hintText,
          prefixIcon: icon,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        ));
  }
}
