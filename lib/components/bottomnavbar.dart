// import 'package:curved_navigation_bar/curved_navigation_bar.dart';
// import 'package:flutter/material.dart';
// import 'package:mca_project/pages/profilpage.dart';
// import 'package:mca_project/pages/homepage.dart';
// import 'package:mca_project/pages/cartpage.dart';



// class MyBottomNavBar extends StatefulWidget {
//   const MyBottomNavBar(
//       {super.key, required this.onPageSelected, required this.currentPage});

//   final Function(int) onPageSelected;
//   final int currentPage;

//   @override
//   State<MyBottomNavBar> createState() => _MyBottomNavBarState();
// }

// class _MyBottomNavBarState extends State<MyBottomNavBar> {
//   @override
//   Widget build(BuildContext context) {
//     return CurvedNavigationBar(
//       index: widget.currentPage, 
//       height: 65,
//       backgroundColor: Colors.white,
//       color: primecolor,
//       animationDuration: Duration(milliseconds: 500),
//       onTap: (int index) {
//         widget.onPageSelected(
//             index); 
//       },
//       items: [
//         Icon(Icons.home),
//         Icon(Icons.shopping_bag),
//         Icon(Icons.person_2),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:mca_project/pages/homepage.dart';
import 'package:mca_project/pages/cartpage.dart';
import 'package:mca_project/pages/profilpage.dart';


class MyBottomNavBar extends StatefulWidget {
  const MyBottomNavBar({super.key});

  @override
  State<MyBottomNavBar> createState() => _MyBottomNavBarState();
}

class _MyBottomNavBarState extends State<MyBottomNavBar> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    MyHomePage(),
    MyCart(),
    MyProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Display selected page
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        selectedItemColor: Colors.blue, // Active item color
        unselectedItemColor: Colors.grey, // Inactive item color
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
