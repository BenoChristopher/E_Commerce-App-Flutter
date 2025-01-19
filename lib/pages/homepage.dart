import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../components/mydrawer.dart';
import '../provider/userprovider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  // String userName = "";
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadUsername();
  }

  void _loadUsername() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final username = currentUser.displayName ?? "User";
      // Update the UserProvider with the username
      Provider.of<UserProvider>(context, listen: false).setUsername(username);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: MyDrawer(),
      ),
      appBar: AppBar(
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag_sharp)),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 27, left: 23, right: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade700,
                    )),
                child: TextField(
                  decoration: InputDecoration(border: InputBorder.none),
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    return Text(
                      'Hello, ${userProvider.userName}',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                      ),
                    );
                  },
                ),
                // Text(
                //   'Hello Ben',
                //   style: GoogleFonts.inter(
                //       fontSize: 20,
                //       color: Colors.black,
                //       fontWeight: FontWeight.w600),
                // ),
                SizedBox(
                  width: 7,
                ),
                SizedBox(
                    height: 20,
                    width: 20,
                    child: Image.asset('asset/images/Vector.png')),
              ],
            ),
            Text(
              "Lets start shopping",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700]),
            )
          ],
        ),
      ),
    );
  }
}
