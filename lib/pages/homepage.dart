import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mca_project/pages/productpage.dart';
import 'package:mca_project/pages/profilepage.dart';
import 'package:provider/provider.dart';

import '../components/bottomnavbar.dart';
import '../components/mydrawer.dart';
import '../provider/userprovider.dart';
import 'cartpage.dart';

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
        title: Text(
          'Home',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.shopping_bag_sharp)),
        ],
      ),
      bottomNavigationBar: MyBottomNavBar(
        onPageSelected: onPageSelected,
        currentPage: currentPage, // Pass the currentPage here
      ),
      body: IndexedStack(
        index: currentPage,
        children: [
          ProductPage(),
          MyProfile(),
          MyCart(),
        ],
      ),
    );
  }
}

// class ProductPage extends StatelessWidget {
//   const ProductPage({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 27, left: 23, right: 23),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             children: [
//               Consumer<UserProvider>(
//                 builder: (context, userProvider, child) {
//                   return Text(
//                     'Hello, ${userProvider.userName}',
//                     style: GoogleFonts.inter(
//                       fontSize: 24,
//                       color: Colors.black,
//                       fontWeight: FontWeight.w600,
//                     ),
//                   );
//                 },
//               ),
//               // Text(
//               //   'Hello Ben',
//               //   style: GoogleFonts.inter(
//               //       fontSize: 20,
//               //       color: Colors.black,
//               //       fontWeight: FontWeight.w600),
//               // ),
//               SizedBox(
//                 width: 7,
//               ),
//               SizedBox(
//                   height: 20,
//                   width: 20,
//                   child: Image.asset('asset/images/Vector.png')),
//             ],
//           ),
//           SizedBox(
//             width: 9,
//           ),
//           Text(
//             "Lets start shopping",
//             style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700]),
//           ),
//           SizedBox(height: 20),
//           Container(
//               padding: EdgeInsets.only(left: 15.0, top: 3.0),
//               width: MediaQuery.of(context).size.width,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(8),
//                   border: Border.all(
//                     color: Colors.grey.shade700,
//                   )),
//               child: TextField(
//                 decoration: InputDecoration(
//                     border: InputBorder.none,
//                     hintText: 'Search for products',
//                     hintStyle: GoogleFonts.inter(
//                         color: Colors.grey.shade700,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w500),
//                     suffixIcon: Icon(
//                       Icons.search,
//                       color: Colors.grey.shade700,
//                     )),
//               )),
//           SizedBox(
//             height: 20,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Categories',
//                 style: GoogleFonts.inter(
//                   fontSize: 20,
//                   color: Colors.black,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               Text(
//                 'see all',
//                 style: GoogleFonts.inter(
//                   fontSize: 16,
//                   color: primecolor,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 15,
//           ),
//           Container(
//             height: 80,
//             child: ListView(scrollDirection: Axis.horizontal, children: [
//               Container(
//                 margin: EdgeInsets.only(bottom: 3),
//                 child: Material(
//                   elevation: 3.0,
//                   borderRadius: BorderRadius.circular(12),
//                   child: Container(
//                     width: 80,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(
//                         color: primecolor,
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                             height: 25,
//                             width: 25,
//                             child: Image.asset('asset/images/bags.png')),
//                         SizedBox(
//                           height: 2,
//                         ),
//                         Text(
//                           'Bags',
//                           style: GoogleFonts.inter(
//                             fontSize: 12,
//                             color: Colors.black54,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 3),
//                 child: Material(
//                   elevation: 3.0,
//                   borderRadius: BorderRadius.circular(12),
//                   child: Container(
//                     width: 80,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(
//                         color: primecolor,
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                             height: 25,
//                             width: 25,
//                             child: Image.asset('asset/images/dress.png')),
//                         SizedBox(
//                           height: 2,
//                         ),
//                         Text(
//                           'Cloths',
//                           style: GoogleFonts.inter(
//                             fontSize: 12,
//                             color: Colors.black54,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 3),
//                 child: Material(
//                   elevation: 3.0,
//                   borderRadius: BorderRadius.circular(12),
//                   child: Container(
//                     width: 80,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(
//                         color: primecolor,
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                             height: 25,
//                             width: 25,
//                             child: Image.asset('asset/images/shoes.png')),
//                         SizedBox(
//                           height: 2,
//                         ),
//                         Text(
//                           'Shoes',
//                           style: GoogleFonts.inter(
//                             fontSize: 12,
//                             color: Colors.black54,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 30,
//               ),
//               Container(
//                 margin: EdgeInsets.only(bottom: 3),
//                 child: Material(
//                   elevation: 3.0,
//                   borderRadius: BorderRadius.circular(12),
//                   child: Container(
//                     width: 80,
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//                     decoration: BoxDecoration(
//                         color: primecolor,
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
//                             height: 25,
//                             width: 25,
//                             child: Image.asset('asset/images/watches.png')),
//                         SizedBox(
//                           height: 2,
//                         ),
//                         Text(
//                           'Watches',
//                           style: GoogleFonts.inter(
//                             fontSize: 12,
//                             color: Colors.black54,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ]),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Text('Featured products',
//               style: GoogleFonts.inter(
//                 fontSize: 20,
//                 color: Colors.black,
//                 fontWeight: FontWeight.w600,
//               )),
//           SizedBox(
//             height: 10,
//           ),
//           Container(
//             padding: const EdgeInsets.all(20.0),
//             height: 350,
//             // width: MediaQuery.of(context).size.width,
//             width: 250,
//             decoration: BoxDecoration(
//                 color: Colors.grey.shade300,
//                 borderRadius: BorderRadius.circular(16)),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 SizedBox(child: Image.asset('asset/images/shoe2.png')),
//                 SizedBox(height: 5),
//                 Text(
//                     'jbfsjdfbsdvnmdbsdb jdbfjsfbjsf fsbfsfbsjf bfjsbfj jfbjsfbjsbfjsb'),
//                 Row(
//                   children: [
//                     Column(
//                       // mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Air Jordan',
//                           style: GoogleFonts.inter(
//                             fontSize: 14,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                         Text(
//                           '\$500',
//                           style: GoogleFonts.inter(
//                             fontSize: 14,
//                             color: Colors.black,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
