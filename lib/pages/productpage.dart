import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mca_project/auth/database.dart';
import 'package:mca_project/pages/homepage.dart';
import 'package:mca_project/provider/userprovider.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../components/category.dart';
import 'detailspage.dart';

class ProductPage extends StatefulWidget {
 


  
  const ProductPage({
    super.key,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}
 
 

class _ProductPageState extends State<ProductPage> {
   Stream? productStream;

  onLoadData() async{
  productStream = await DataBaseMethod().getAllProduct();

  if(mounted){
    setState(() {
    
  });
    
  }
  
 }
 

   @override
  void initState() {
   
    // TODO: implement initState
    super.initState();
     Future.delayed(Duration.zero, () {
    onLoadData();
  });
  }

  

  Widget allproduct() {
  if (productStream == null) {
    return Center(child: CircularProgressIndicator());
  }

  return 
  
  StreamBuilder(
      stream: productStream,
      builder: (context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Center(child: Text("No Products Available"));
        }

        return SizedBox(
          height: 500,
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];

                return Column(
                  children: [
                    Container(
                      //padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.only(right: 20),
                      height: 350,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(16)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                       
                          ds["Image"] != null && ds["Image"].isNotEmpty
                              ? Padding(
                                padding: const EdgeInsets.only(top: 20,left: 0,right: 0,bottom: 0),
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      ds["Image"],
                                      height: 200,
                                      width: 200,
                                      fit: BoxFit.fitWidth,
                                      loadingBuilder: (context, child, progress) {
                                        if (progress == null) return child;
                                        return Shimmer.fromColors(
                                          baseColor: Colors.grey[300]!,
                                          highlightColor: Colors.grey[100]!,
                                          child: Container(
                                            height: 200,
                                            width: 200,
                                            decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(8),
          ),

                                          ),
                                          
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) =>
                                          Icon(Icons.image_not_supported,
                                              size: 50, color: Colors.grey),
                                    ),
                                  ),
                              )
                              : Icon(Icons.image_not_supported,
                                  size: 50, color: Colors.grey),
                
                          SizedBox(height: 1),
                
                         
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Text(ds["Description"],maxLines: 3,),
                          ),
                
                          Container(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        ds["Name"],
                                        maxLines: 1,
                                        style: GoogleFonts.inter(
                                          
                                          fontSize: 15,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "\$" + ds["Price"],
                                      style: GoogleFonts.inter(
                                        fontSize: 14,
                                        color: Colors.black,
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
                                  image: ds["Image"], // Firebase Image URL
                                  description: ds["Description"],
                                  name: ds["Name"],
                                  price: ds["Price"],
                                )));
                  },
                                  child: Container(
                                    height: 50,
                                    width: 50,
                                     decoration: BoxDecoration(
                                            
                                          color: primecolor,
                                            borderRadius: BorderRadius.circular(8),
                                                        
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
              }),
        );
      });


}




  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top: 27, left: 23, right: 23),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Consumer<UserProvider>(
                  builder: (context, userProvider, child) {
                    return Flexible(
                      child: Container(
                       // alignment: Alignment.topRight,
                        // width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(
                          'Hello, ${userProvider.userName}',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  },
                ),
               
                SizedBox(
                  width: 7,
                ),
                SizedBox(
                    height: 25,
                    width: 25,
                    child: Image.asset('asset/images/Vector.png')),
              ],
            ),
            SizedBox(
              width: 9,
            ),
            Text(
              "Lets start shopping",
              style: GoogleFonts.inter(fontSize: 12, color: Colors.grey[700]),
            ),
            SizedBox(height: 20),
            Container(
                padding: EdgeInsets.only(left: 15.0, top: 3.0),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: Colors.grey.shade700,
                    )),
                child: TextField(
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search for products',
                      hintStyle: GoogleFonts.inter(
                          color: Colors.grey.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.w500),
                      suffixIcon: Icon(
                        Icons.search,
                        color: Colors.grey.shade700,
                      )),
                )),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Categories',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'see all',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    color: primecolor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Container(
              height: 80,
              child:CategoriesList(),
              
            ),
            SizedBox(
              height: 20,
            ),
            Text('Featured products',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
               height: 500, 
               child: allproduct())
          ],
        ),
      ),
    );
  }
}
