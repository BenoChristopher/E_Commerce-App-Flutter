import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mca_project/pages/detailspage.dart';
import 'package:mca_project/pages/homepage.dart';
import 'package:shimmer/shimmer.dart';

class CategoryProductsPage extends StatelessWidget {
  final String category;

  CategoryProductsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$category Products 📦", style: GoogleFonts.blinker(fontWeight: FontWeight.w500,color: Colors.grey[700]),),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Event") 
            .where("Category", isEqualTo: category) // Filter by category
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No products found for $category"));
          }

          var products = snapshot.data!.docs;

          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              var product = products[index].data() as Map<String, dynamic>;

              // return Card(
              //   elevation: 4,
              //   margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              //   child: ListTile(
              //     leading: product["Image"] != null
              //         ? Image.network(product["Image"], width: 50, height: 50, fit: BoxFit.cover)
              //         : Icon(Icons.image_not_supported),
              //     title: Text(product["Name"] ?? "No Name", style: GoogleFonts.inter(fontSize: 16)),
              //     subtitle: Text("\$${product["Price"] ?? "0"}", style: GoogleFonts.inter(fontSize: 14, color: Colors.green)),
              //   ),
              // );
             return Column(
                  children: [
                    Container(
                      //margin: EdgeInsets.only(left: 20, right: 20, top: 20),
                     
                      height: 290,
                      width: 220,
                      decoration: BoxDecoration(
                      //  border: Border.all(color: Colors.black),
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                       
                          product["Image"] != null && product["Image"].isNotEmpty
                              ? Padding(
                                padding: const EdgeInsets.only(top: 20,left: 20,right: 20),
                                child: Container(
                                  decoration: BoxDecoration(
                                   //  border: Border.all(color: Colors.black),
                                  ),
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        product["Image"],
                                        height: 180,
                                        width: 180,
                                        fit: BoxFit.fitWidth,
                                        loadingBuilder: (context, child, progress) {
                                          if (progress == null) return child;
                                          return Center(
                                            child: Shimmer.fromColors(
                                              baseColor: Colors.grey[300]!,
                                              highlightColor: Colors.grey[100]!,
                                              child: Container(
                                                height: 150,
                                                width: 150,
                                                decoration: BoxDecoration(
                                                color: Colors.grey[300],
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                                                              
                                              ),
                                              
                                            ),
                                          );
                                        },
                                        errorBuilder: (context, error, stackTrace) =>
                                            Icon(Icons.image_not_supported,
                                                size: 50, color: Colors.grey),
                                      ),
                                    ),
                                ),
                              )
                              : Icon(Icons.image_not_supported,
                                  size: 50, color: Colors.grey),
                
                       
                
                         
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(product["Description"],maxLines: 2,style: GoogleFonts.inter(fontSize: 12),),
                          ),
                          SizedBox(height: 3,),
                
                          Container(
                            decoration: BoxDecoration( color: Colors.grey.shade800,borderRadius: BorderRadius.only(bottomLeft: Radius.circular(16),bottomRight: Radius.circular(16))),  
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        product["Name"],
                                        maxLines: 1,
                                        style: GoogleFonts.inter(
                                          
                                          fontSize: 13,
                                          color: Colors.grey[50],
                                          //color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "\$" + product["Price"],
                                      style: GoogleFonts.inter(
                                        fontSize: 12,
                                        color: Colors.grey[50],
                                        //color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8),
                                  ],
                                ),
                                GestureDetector(
                                   onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                                  image: product["Image"], // Firebase Image URL
                                  description: product["Description"],
                                  name: product["Name"],
                                  price: product["Price"],
                                )));
                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                     decoration: BoxDecoration(
                                            
                                          color: primecolor,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(16),
                                              topLeft: Radius.circular(16),
                                              
                                            )
                                                        
                                          ),
                                    child: Icon(
                                      Icons.add,color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
            },
          );
        },
      ),
    );
  }
}
