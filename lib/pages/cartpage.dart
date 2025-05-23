


// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import '../provider/userprovider.dart';

// class MyCart extends StatefulWidget {
//   @override
//   _MyCartState createState() => _MyCartState();
// }

// class _MyCartState extends State<MyCart> {
//   bool _isLoading = true;
//   String _deletingItemId = ""; // Track which item is being deleted

//   @override
//   void initState() {
//     super.initState();
//     loadCartData();
//   }

//   Future<void> loadCartData() async {
//     final userProvider = Provider.of<UserProvider>(context, listen: false);
//     await userProvider.loadCart();
//     setState(() {
//       _isLoading = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           "My Cart Items 🛒",
//           style: GoogleFonts.blinker(
//             fontWeight: FontWeight.w500,
//             color: Colors.grey[700],
//           ),
//         ),
//       ),
//       body: _isLoading
//           ? Center(child: CircularProgressIndicator())
//           : userProvider.cart.isEmpty
//               ? Center(child: Text("Your cart is empty!"))
//               : Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                   child: ListView.builder(
//                     itemCount: userProvider.cart.length,
//                     itemBuilder: (context, index) {
//                       final cartItem = userProvider.cart[index];

//                       return Container(
//                         margin: EdgeInsets.only(bottom: 20),
//                         width: MediaQuery.of(context).size.width,
//                         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade100,
//                           borderRadius: BorderRadius.circular(8),
//                           boxShadow: [
//                             BoxShadow(
//                               color: Colors.white,
//                               blurRadius: 2,
//                               spreadRadius: 1,
//                               offset: Offset(3, 3),
//                               blurStyle: BlurStyle.normal,
//                             ),
//                           ],
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Column(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Container(
//                                   height: 120,
//                                   width: 130,
//                                   decoration: BoxDecoration(
//                                     color: Colors.grey.shade300,
//                                     borderRadius: BorderRadius.circular(8),
//                                   ),
//                                   child: ClipRRect(
//                                     borderRadius: BorderRadius.circular(8),
//                                     child: SizedBox(
//                                       height: 120,
//                                       width: 130,
//                                       child: Image.network(
//                                         cartItem["image"],
//                                         fit: BoxFit.fitWidth,
//                                         loadingBuilder: (context, child, loadingProgress) {
//                                           if (loadingProgress == null) return child;
//                                           return Center(child: CircularProgressIndicator());
//                                         },
//                                         errorBuilder: (context, error, stackTrace) {
//                                           return Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
//                                         },
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Container(
//                                   padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                                   decoration: BoxDecoration(
//                                     border: Border.all(color: Colors.grey.shade400, width: 1),
//                                     borderRadius: BorderRadius.circular(4),
//                                   ),
//                                   child: Text(
//                                     "Qty: ${cartItem["quantity"]}",
//                                     style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
//                                   ),
//                                 )
//                               ],
//                             ),
//                             SizedBox(width: 30),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 SizedBox(
//                                   width: 190,
//                                   child: Text(
//                                     cartItem["name"],
//                                     maxLines: 1,
//                                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
//                                   ),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   "\$${cartItem["price"]}",
//                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[500]),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   "Size: ${cartItem["size"]}",
//                                   style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
//                                 ),
//                                 SizedBox(height: 10),
//                                 Text(
//                                   "Total: \$${cartItem["totalPrice"]}",
//                                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
//                                 ),
//                                 SizedBox(height: 10),

//                                 // DELETE BUTTON WITH LOADING INDICATOR
//                                 MaterialButton(
//                                   onPressed: () async {
//                                     setState(() {
//                                       _deletingItemId = cartItem["id"];
//                                     });

//                                     await userProvider.removeFromCart(cartItem["id"], index);

//                                     setState(() {
//                                       _deletingItemId = "";
//                                     });
//                                   },
//                                   color: Colors.red,
//                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//                                   child: _deletingItemId == cartItem["id"]
//                                       ? SizedBox(
//                                           width: 20,
//                                           height: 20,
//                                           child: CircularProgressIndicator(
//                                             color: Colors.white,
//                                             strokeWidth: 2,
//                                           ),
//                                         )
//                                       : Row(
//                                           children: [
//                                             Icon(Icons.delete, color: Colors.white, size: 20),
//                                             SizedBox(width: 5),
//                                             Text(
//                                               "Delete",
//                                               style: GoogleFonts.inter(
//                                                 fontWeight: FontWeight.bold,
//                                                 color: Colors.white,
//                                                 fontSize: 14,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mca_project/pages/addresspage.dart';
import 'package:mca_project/pages/homepage.dart';
import 'package:provider/provider.dart';
import '../provider/userprovider.dart';


class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  bool _isLoading = true;
  String _deletingItemId = ""; // Track which item is being deleted

  @override
  void initState() {
    super.initState();
    loadCartData();
  }

  Future<void> loadCartData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadCart();
    setState(() {
      _isLoading = false;
    });
  }

  double getTotalAmount(List<Map<String, dynamic>> cart) {
  return cart.fold(0, (sum, item) {
    double price = double.tryParse(item["totalPrice"].toString()) ?? 0.0;
    return sum + price;
  });
}


  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    double totalAmount = getTotalAmount(userProvider.cart);

    return Scaffold(
      appBar: AppBar(
       
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : userProvider.cart.isEmpty
              ? Center(child: Text("Your cart is empty!"))
              : Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: ListView.builder(
                          itemCount: userProvider.cart.length,
                          itemBuilder: (context, index) {
                            final cartItem = userProvider.cart[index];

                            return Container(
                              margin: EdgeInsets.only(bottom: 20),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.white,
                                    blurRadius: 2,
                                    spreadRadius: 1,
                                    offset: Offset(3, 3),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                        height: 120,
                                        width: 130,
                                        decoration: BoxDecoration(
                                          color: Colors.grey.shade300,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(8),
                                          child: Image.network(
                                            cartItem["image"],
                                            fit: BoxFit.fitWidth,
                                            loadingBuilder: (context, child, loadingProgress) {
                                              if (loadingProgress == null) return child;
                                              return Center(child: CircularProgressIndicator());
                                            },
                                            errorBuilder: (context, error, stackTrace) {
                                              return Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
                                            },
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                        decoration: BoxDecoration(
                                          border: Border.all(color: Colors.grey.shade400, width: 1),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          "Qty: ${cartItem["quantity"]}",
                                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(width: 30),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 190,
                                        child: Text(
                                          cartItem["name"],
                                          maxLines: 1,
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "\$${cartItem["price"]}",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[500]),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Size: ${cartItem["size"]}",
                                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
                                      ),
                                      SizedBox(height: 10),
                                      Text(
                                        "Total: \$${cartItem["totalPrice"]}",
                                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                                      ),
                                      SizedBox(height: 10),

                                      // DELETE BUTTON WITH LOADING INDICATOR
                                      MaterialButton(
                                        onPressed: () async {
                                          setState(() {
                                            _deletingItemId = cartItem["id"];
                                          });

                                          await userProvider.removeFromCart(cartItem["id"], index);

                                          setState(() {
                                            _deletingItemId = "";
                                          });
                                        },
                                        color: Colors.red,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                        child: _deletingItemId == cartItem["id"]
                                            ? SizedBox(
                                                width: 20,
                                                height: 20,
                                                child: CircularProgressIndicator(
                                                  color: Colors.white,
                                                  strokeWidth: 2,
                                                ),
                                              )
                                            : Row(
                                                children: [
                                                  Icon(Icons.delete, color: Colors.white, size: 20),
                                                  SizedBox(width: 5),
                                                  Text(
                                                    "Delete",
                                                    style: GoogleFonts.inter(
                                                      fontWeight: FontWeight.bold,
                                                      color: Colors.white,
                                                      fontSize: 14,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),

                    // TOTAL AMOUNT & CHECKOUT BUTTON
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: Colors.grey.shade300)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Total Amount:",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                              ),
                              Text(
                                "\$${totalAmount.toStringAsFixed(2)}",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green),
                              ),
                            ],
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => MyAddressPage()),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: primecolor,
                              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 30),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                            ),
                            child: Text(
                              "Checkout",
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}

