


import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/userprovider.dart';

class MyCart extends StatefulWidget {
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  bool _isLoading = true; // Track loading state

  @override
  void initState() {
    super.initState();
    loadCartData(); // Load cart data when the screen opens
  }

  Future<void> loadCartData() async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    await userProvider.loadCart();
    setState(() {
      _isLoading = false; 
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(title: Text("Your Cart")),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) 
          : userProvider.cart.isEmpty
              ? Center(child: Text("Your cart is empty!"))
              : ListView.builder(
                  itemCount: userProvider.cart.length,
                  itemBuilder: (context, index) {
                    final cartItem = userProvider.cart[index];

                    return Card(
                      
                      
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              cartItem["image"],
                              width: 150,
                              height: 150,
                              fit: BoxFit.fitWidth,
                            ),
                            SizedBox(width: 15),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItem["name"],
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                                  ),
                                  SizedBox(height: 5),
                                  Text("\$${cartItem["price"]}", style: TextStyle(fontSize: 16, color: Colors.grey[700])),
                                  SizedBox(height: 5),
                                  Text("Size: ${cartItem["size"]}", style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                   Text("No of products${cartItem["quantity"]}",style: TextStyle(color: Colors.grey[700],fontSize: 18),),
                                  SizedBox(height: 5),
                                  Text("\$${cartItem["totalPrice"]}",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete, color: Colors.red, size: 28),
                              onPressed: () async {
                                await userProvider.removeFromCart(cartItem["id"], index);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}


