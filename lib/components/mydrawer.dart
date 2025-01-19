import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logoutUser() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    var primecolor = const Color(0xFF00c7e7);

    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          child: Column(children: [
            SizedBox(height: 80, child: Image.asset('asset/bag.png')),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'CART',
                  style: GoogleFonts.bubblegumSans(
                      textStyle: TextStyle(
                          fontSize: 25,
                          color: primecolor,
                          fontWeight: FontWeight.bold)),
                ),
                Text(
                  'IFY',
                  style: GoogleFonts.bubblegumSans(
                      textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold)),
                ),
              ],
            )
          ]),
        ),
        ListTile(
          onTap: logoutUser,
          title: Text('Logout'),
          leading: IconButton(
            icon: Icon(Icons.logout),
            onPressed: logoutUser,
          ),
        ),
      ],
    ));
  }
}
