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

 
}



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

  List<String> titles = ["Home", "Cart", "Profile"];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      drawer: Drawer(
        child: MyDrawer(),
      ),
      appBar: AppBar(
        title: Text(
            titles[currentPage],
          style: GoogleFonts.blinker(
            fontWeight: FontWeight.bold,
            //color: Colors.grey[700],
          ),
        ),
       
        actions: [
        IconButton(onPressed: () {}, icon: Icon(Icons.favorite_rounded)),
        ],
      ),
    
      
      // bottomNavigationBar: MyBottomNavBar(
      //   onPageSelected: onPageSelected,
      //   currentPage: currentPage, 
      // ),
      bottomNavigationBar: BottomNavigationBar(
  currentIndex: currentPage,
  onTap: onPageSelected,
  selectedItemColor: primecolor,  // Highlighted color
  unselectedItemColor: Colors.grey,
  items: [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
    BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
  ],
),

      body: IndexedStack(
        index: currentPage,
        children: [
          ProductPage(),
         
          MyCart(),
           MyProfile(),
        ],
      ),
    );
  }
}

