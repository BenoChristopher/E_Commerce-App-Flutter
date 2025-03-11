import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mca_project/pages/productpage.dart';
import 'package:mca_project/pages/cartpage.dart';
import 'package:provider/provider.dart';

import '../components/bottomnavbar.dart';
import '../components/mydrawer.dart';
import '../provider/userprovider.dart';
import 'profilpage.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();

  // String userName = "";
}

// List pages = [
//   {
//     '/homepage': MyHomePage(),
//     '/cartpage':MyCart()
//   }
// ];

var primecolor = const Color(0xFF00c7e7);

int currentPage = 0;

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

  void onPageSelected(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      drawer: Drawer(
        child: MyDrawer(),
      ),
      appBar: AppBar(
       
        actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag_sharp)),
        ],
      ),
    
      // appBar: AppBar(
      //   title: Text(
      //     'Home',
      //     style: TextStyle(fontWeight: FontWeight.bold),
      //   ),
      //   actions: [
      //     IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag_sharp)),
      //   ],
      // ),
      bottomNavigationBar: MyBottomNavBar(
        onPageSelected: onPageSelected,
        currentPage: currentPage, 
      ),
      body: IndexedStack(
        index: currentPage,
        children: [
          ProductPage(),
         
          MyCart(),
           MyProfile(text: "Profile Page",),
        ],
      ),
    );
  }
}

