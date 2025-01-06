import 'package:flutter/material.dart';

class MyWelComePage extends StatelessWidget {
  const MyWelComePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          children: [
            Image.asset('asset/bag.png'),
          ],
        ),
      ),
    );
  }
}
