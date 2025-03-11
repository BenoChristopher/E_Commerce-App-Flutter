import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mca_project/pages/profilpage.dart';
import 'package:mca_project/pages/homepage.dart';
import 'package:mca_project/pages/cartpage.dart';

// class MyBottomNavBar extends StatefulWidget {
//   const MyBottomNavBar({super.key});

//   @override
//   State<MyBottomNavBar> createState() => _MyBottomNavBarState();
// }

// class _MyBottomNavBarState extends State<MyBottomNavBar> {
//   late List<Widget> pages;
//   late MyHomePage homePage;
//   late MyCart cartPage;
//   late MyProfile profilePage;
//   int currentPage = 0;

//   @override
//   void initState() {
//     // TODO: implement initState

//     homePage = MyHomePage();
//     cartPage = MyCart();
//     profilePage = MyProfile();

//     pages = [homePage, cartPage, profilePage];
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       bottomNavigationBar: CurvedNavigationBar(
//         items: [pages[0]],
//       ),
//     );
//   }
// }

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar(
      {super.key, required this.onPageSelected, required this.currentPage});

  final Function(int) onPageSelected;
  final int currentPage; // Pass the currentPage to synchronize

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      index: widget.currentPage, // Use the currentPage passed from MyHomePage
      height: 65,
      backgroundColor: Colors.white,
      color: primecolor,
      animationDuration: Duration(milliseconds: 500),
      onTap: (int index) {
        widget.onPageSelected(
            index); // Notify MyHomePage about the page selection
      },
      items: [
        Icon(Icons.home),
        Icon(Icons.shopping_bag),
        Icon(Icons.person_2),
      ],
    );
  }
}
