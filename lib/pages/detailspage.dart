
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mca_project/pages/homepage.dart';
import 'package:provider/provider.dart';
import '../provider/userprovider.dart';
import '../components/mybutton.dart';

class ProductDetailPage extends StatefulWidget {
  final String image, description, name, price;

  ProductDetailPage({
    required this.image,
    required this.description,
    required this.name,
    required this.price,
  });

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}


class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1; 
  String selectedSize = "S";
  final Map<String, int> sizePriceIncrement = {
    "S": 0,
    "M": 20,
    "L": 40,
    "XL": 60,
  };

  @override
  Widget build(BuildContext context) {
    double basePrice = double.tryParse(widget.price) ?? 0.0;
    double finalPrice = basePrice + sizePriceIncrement[selectedSize]!;
    double totalPrice = finalPrice * quantity; 

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 40, bottom: 20),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: primecolor,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(140)),
                ),
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset(widget.image),
                ),
              ),
              Positioned(
                top: 60,
                left: 23,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90),
                    child: Container(
                      decoration: BoxDecoration(color: Colors.white),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back_ios_new_rounded),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 35),
          Padding(
            padding: EdgeInsets.only(left: 23, right: 23),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.name, style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w600)),
                SizedBox(height: 16),

                
                Text("Select Size:", style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                DropdownButton<String>(
                  value: selectedSize,
                  items: sizePriceIncrement.keys.map((size) {
                    return DropdownMenuItem<String>(
                      value: size,
                      child: Text(size, style: GoogleFonts.inter(fontSize: 16)),
                    );
                  }).toList(),
                  onChanged: (newSize) {
                    setState(() {
                      selectedSize = newSize!;
                    });
                  },
                ),

                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('MRP:', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w400)),
                    SizedBox(width: 8),
                    Text(
                      "\$ ${totalPrice.toStringAsFixed(0)}",
                      style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
                SizedBox(height: 16),

                Row(
                  children: [
                    Text('No of items:', style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(width: 8),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                      width: 120,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade600, width: 2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              if (quantity > 1) {
                                setState(() {
                                  quantity--;
                                });
                              }
                            },
                            child: Text('-', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            quantity.toString(),
                            style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold, color: primecolor),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Text('+', style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                SizedBox(height: 35),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyButton(
                      color: Colors.white,
                      onPressed: () {},
                      buttonname: 'Add to Wishlist',
                      icon: Icon(Icons.favorite),
                    ),
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        return MyButton(
                          color: primecolor,
                          onPressed: () async {
                            await userProvider.addCart({
                              "name": widget.name,
                              "price": finalPrice.toString(),
                              "image": widget.image,
                              "size": selectedSize, 
                              "quantity": quantity,
                              "totalPrice": totalPrice.toStringAsFixed(0),
                            });

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("${widget.name} (Size: $selectedSize) added to cart!")),
                            );
                          },
                          buttonname: 'Add to Cart',
                          icon: Icon(Icons.shopping_bag),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
