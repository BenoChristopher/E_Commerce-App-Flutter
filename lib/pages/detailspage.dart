
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
                padding: EdgeInsets.only(left: 30, right: 30, top: 50, bottom:0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                 boxShadow:[
    BoxShadow(
          color: Color.fromRGBO(17, 17, 26, 0.1),
          blurRadius: 0,
          spreadRadius: 0,
          offset: Offset(
             0,
             1,
          ),
       ),
        BoxShadow(
          color: Color.fromRGBO(17, 17, 26, 0.1),
          blurRadius: 24,
          spreadRadius: 0,
          offset: Offset(
             0,
             8,
          ),
       ),
        BoxShadow(
          color: Color.fromRGBO(17, 17, 26, 0.1),
          blurRadius: 48,
          spreadRadius: 0,
          offset: Offset(
             0,
             16,
          ),
       ),
       
],
  
                  
                  color: primecolor,
                  borderRadius: BorderRadius.only(bottomRight: Radius.circular(40), bottomLeft: Radius.circular(40)),
                ),
                child: SizedBox(
                  height: 320,
                  width: 300,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40,top: 40,bottom: 40),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                          widget.image,
                          fit: BoxFit.fitWidth,
                          loadingBuilder: (context, child, progress) {
                            if (progress == null) return child;
                            return Center(child: CircularProgressIndicator()); // Show loading spinner
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Icon(Icons.image_not_supported, size: 50, color: Colors.grey);
                          },
                        ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 40,
                left: 20,
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
                Text(widget.name, style: GoogleFonts.blinker(fontSize: 24, fontWeight: FontWeight.w600)),
                   SizedBox(height: 16),
                 Text(widget.description, style: GoogleFonts.blinker(fontSize: 16, fontWeight: FontWeight.w300)),

                SizedBox(height: 16),

                
                Text("Select Size:", style: GoogleFonts.blinker(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 16),
               
                Container(
  padding: EdgeInsets.symmetric(horizontal: 12),
  decoration: BoxDecoration(
    border: Border.all(color: Colors.black, width: 1.5), 
        borderRadius: BorderRadius.circular(8), // Rounded Corners
    color: Colors.white, // Background color
  ),
  child: DropdownButtonHideUnderline( // Removes default underline
    child: DropdownButton<String>(
      value: selectedSize,
      isExpanded: false, // Ensures full width
      icon: Icon(Icons.arrow_drop_down, color: Colors.black), // Dropdown icon
      style: GoogleFonts.inter(fontSize: 16, color: Colors.black,fontWeight: FontWeight.w500), // Text styling
      items: sizePriceIncrement.keys.map((size) {
        return DropdownMenuItem<String>(
          value: size,
          child: Text(size),
        );
      }).toList(),
      onChanged: (newSize) {
        setState(() {
          selectedSize = newSize!;
        });
      },
    ),
  ),
)
,

                SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('MRP:', style: GoogleFonts.blinker(fontSize: 16, fontWeight: FontWeight.w400)),
                    SizedBox(width: 8),
                    Text(
                      "\$ ${totalPrice.toStringAsFixed(0)}",
                      style: GoogleFonts.blinker(fontSize: 16, fontWeight: FontWeight.w800),
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
                            child: Text('-', style: GoogleFonts.blinker(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                          Text(
                            quantity.toString(),
                            style: GoogleFonts.blinker(fontSize: 18, fontWeight: FontWeight.bold, color: primecolor),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                quantity++;
                              });
                            },
                            child: Text('+', style: GoogleFonts.blinker(fontSize: 18, fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),

                SizedBox(height: 55),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // MyButton(

                    //   iconcolor: Colors.white,
                     
                    //   color: primecolor,
                    //   onPressed: () {},
                    //   buttonname: 'Add to Wishlist',textcolor: Colors.black,
                    //   icon: Icon(Icons.favorite,color: Colors.white,),
                    // ),
                    Consumer<UserProvider>(
                      builder: (context, userProvider, child) {
                        return MyButton(
                          iconcolor:   Colors.grey.shade50,
                          // textcolor: Colors.white,
                          // iconcolor: Colors.white,
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
                          textcolor: Colors.grey.shade50,

                          icon: Icon(Icons.shopping_bag,color: Colors.white,),
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
