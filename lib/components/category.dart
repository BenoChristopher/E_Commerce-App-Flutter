
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/categoryproductpage.dart';


class CategoriesList extends StatelessWidget {
  final Color primecolor = Color(0xFF00c7e7);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance.collection("categories").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        }
        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return Center(child: Text("No categories found"));
        }

        var categories = snapshot.data!.docs.map((doc) {
          return doc.data()?["name"] ?? "Unknown";
        }).toList();

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to the CategoryProductsPage with selected category
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CategoryProductsPage(category: categories[index]),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.only(right: 20),
                child: Container(
                  height: 70,
                  width: 80,
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 50,
                      decoration: BoxDecoration(
                        color: primecolor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 30, width: 30, child: Opacity(
                            opacity: 0.8,
                            child: Image.asset('asset/images/box.png'))),
                          SizedBox(height: 2),
                          Text(
                            categories[index],
                            style: GoogleFonts.inter(fontSize: 12, color: Colors.black54, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
