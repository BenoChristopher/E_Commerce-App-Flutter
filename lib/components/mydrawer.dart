// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// import '../admin/uploadproduct.dart';

// class MyDrawer extends StatelessWidget {
//   const MyDrawer({super.key});

//   // void logoutUser() {
//   //   FirebaseAuth.instance.signOut();
//   // }

//   Future<void> signOutUser() async {
//   try {
//     FirebaseAuth.instance.signOut();
//     await GoogleSignIn().signOut(); // Sign out from Google
//     await FirebaseAuth.instance.signOut(); // Sign out from Firebase
//     print("User signed out successfully");
//   } catch (e) {
//     print("Error signing out: $e");
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     var primecolor = const Color(0xFF00c7e7);

//     return Drawer(
//         child: ListView(
//       children: [
//         DrawerHeader(
//           child: Column(children: [
//             SizedBox(height: 80, child: Image.asset('asset/images/bag.png')),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'CART',
//                   style: GoogleFonts.bubblegumSans(
//                       textStyle: TextStyle(
//                           fontSize: 25,
//                           color: primecolor,
//                           fontWeight: FontWeight.bold)),
//                 ),
//                 Text(
//                   'IFY',
//                   style: GoogleFonts.bubblegumSans(
//                       textStyle: TextStyle(
//                           fontSize: 25,
//                           color: Colors.grey[700],
//                           fontWeight: FontWeight.bold)),
//                 ),
//               ],
//             )
//           ]),
//         ),
//         ListTile(
//           onTap: (){
//             Navigator.of(context).push(
//     MaterialPageRoute(builder: (context) => UploadProduct()),
//   );
//           },
//           title: Text('Admin'),
//           leading: IconButton(
//             icon: Icon(Icons.admin_panel_settings),
//             onPressed: signOutUser,
//           ),
//         ),
//         ListTile(
//           onTap: signOutUser,
//           title: Text('Logout'),
//           leading: IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: signOutUser,
//           ),
//         ),
//       ],
//     ));
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../admin/uploadproduct.dart';

class MyDrawer extends StatelessWidget {
   MyDrawer({super.key});

  // List of admin users (can be emails or UIDs)
  final List<String> adminEmails = ["benochristopher22@gmail.com"];

  // Check if the current user is an admin
  bool isAdmin(User? user) {
    return user != null && adminEmails.contains(user.email);
  }

  // Sign out function
  Future<void> signOutUser() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      print("User signed out successfully");
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    var primecolor = const Color(0xFF00c7e7);
    User? user = FirebaseAuth.instance.currentUser; // Get current user

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                SizedBox(height: 80, child: Image.asset('asset/images/bag.png')),
                SizedBox(height: 10),
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
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Text(
                      'IFY',
                      style: GoogleFonts.bubblegumSans(
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Show "Admin" option only if user is an admin
          if (isAdmin(user))
            ListTile(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => UploadProduct()),
                );
              },
              title: Text('Admin'),
              leading: Icon(Icons.admin_panel_settings),
            ),

          // Logout option
          ListTile(
            onTap: signOutUser,
            title: Text('Logout'),
            leading: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}

