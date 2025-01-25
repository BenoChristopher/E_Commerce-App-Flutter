import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:mca_project/pages/cartpage.dart';
import 'package:mca_project/pages/homepage.dart';
import 'package:mca_project/pages/profilepage.dart';

class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  late List<Widget> pages;
  late MyHomePage homePage;
  late MyCart cartPage;
  late MyProfile profilePage;
  int currentPage = 0;

  @override
  void initState() {
    // TODO: implement initState

    homePage = MyHomePage();
    cartPage = MyCart();
    profilePage = MyProfile();

    pages = [homePage, cartPage, profilePage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        items: [pages[0]],
      ),
    );
  }
}
