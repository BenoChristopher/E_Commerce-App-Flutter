import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mca_project/auth/database.dart';
import 'package:mca_project/pages/homepage.dart';
import 'package:mca_project/provider/userprovider.dart';
import 'package:provider/provider.dart';

import 'detailspage.dart';

class ProductPage extends StatefulWidget {

  
  const ProductPage({
    super.key,
  });

  @override
  State<ProductPage> createState() => _ProductPageState();
}
 Stream? productStream;

 

class _ProductPageState extends State<ProductPage> {

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

  Widget allproduct(){

    if (productStream == null) {
    return Center(child: CircularProgressIndicator());
  }
    

    return StreamBuilder( 
      stream: productStream,
      builder:(context,AsyncSnapshot snapshot){
      return snapshot.hasData ? SizedBox(
          height: 500,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data.docs.length,
          itemBuilder : (context ,index){
          DocumentSnapshot ds = snapshot.data.docs[index];
          return GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetailPage(
                image: "asset/images/shoe2.png",
                description: ds["Description"],
                name: ds["Name"],
                price: ds["Price"],
                
                  
              )));
            },
            child: Column(
              children: [
                Container(
                 
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.only(right: 20),
                        height: 350,
                        // width: MediaQuery.of(context).size.width,
                        width: 250,
                        decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(16)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(child: Image.asset('asset/images/shoe2.png')),
                            SizedBox(height: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Text(
                                
                                  ds["Description"]),
                            ),
                            Container(
                               padding: const EdgeInsets.only(left: 20.0),
                       
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Column(
                                    // mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                    ds["Name"],
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text("\$"+ds["Price"],
                                        style: GoogleFonts.inter(
                                          fontSize: 14,
                                          color: Colors.black,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      SizedBox(height: 5),
                                    ],
                                  ),
//                                   Consumer<UserProvider>(
//                             builder: (context, userProvider, child) {
//                                     return GestureDetector(
//                                         onTap: () {
//                                          userProvider.addCart({
//                                        "name": ds["Name"],
//                                        "price": ds["Price"],
//                                        "image": "asset/images/shoe2.png"
//                                                       });
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text("Added to cart"), duration: Duration(seconds: 2)),
//         );
//       },
//       child: Container(
//         height: 50,
//         width: 50,
//         decoration: BoxDecoration(
//             color: primecolor,
//             borderRadius: BorderRadius.circular(8)),
//         child: Icon(Icons.add),
//       ),
//     );
//   },
// ),

                                  
                                  //  Consumer<UserProvider>(
                                  //       builder: (context, userProvider, child) {
                                  //         return GestureDetector(
                                  //           onTap: () {
                                  //             userProvider.addCart({
                                  //               "name": ds["Name"],
                                  //               "price": ds["Price"],
                                  //               "image": "asset/images/shoe2.png"
                                  //             });
                                  //             ScaffoldMessenger.of(context).showSnackBar(
                                  //               SnackBar(
                                  //                 content: Text("Added to cart"),
                                  //                 duration: Duration(seconds: 2),
                                  //               ),
                                  //             );
                                  //           },
                                  //           child: Container(
                                  //             height: 50,
                                  //             width: 50,
                                  //             decoration: BoxDecoration(
                                  //                 color: primecolor,
                                  //                 borderRadius: BorderRadius.circular(8)),
                                  //             child: Icon(Icons.add),
                                  //           ),
                                  //         );
                                  //       },
                                  //     ),
                              
                                  // Consumer<UserProvider>(
                                  //   builder: (context, userProvider,child){

                                    
                                  //   return GestureDetector(
                                  //     onTap: (){
                                  //       UserProvider.addCart({
                                  //         "Name": ds["Name"],
                                  //         "Price": ds["Price"],
                                          
                                  //         "Image": "asset/images/shoe2.png",
                                          
                                  //       });
                                  //     },
                                  //     child: Container(
                                  //       height: 50,
                                  //       width: 50,
                                        
                                  //       decoration: BoxDecoration(
                                                                    
                                  //         color: primecolor,
                                  //         borderRadius: BorderRadius.circular(8)
                                  //       ),
                                  //       child: Icon(Icons.add)
                                  //     ),
                                  //   );}
                                  // )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
              ],
            ),
          );
        }),
      )
                              :Container();

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
                    return Container(
                     // alignment: Alignment.topRight,
                       width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(
                        'Hello, ${userProvider.userName}',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
               
                SizedBox(
                  width: 7,
                ),
                SizedBox(
                    height: 20,
                    width: 20,
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
              child: ListView(scrollDirection: Axis.horizontal, children: [
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 80,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: primecolor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset('asset/images/bags.png')),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Bags',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 80,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: primecolor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset('asset/images/dress.png')),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Cloths',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 80,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: primecolor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset('asset/images/shoes.png')),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Shoes',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 30,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 3),
                  child: Material(
                    elevation: 3.0,
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 80,
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                          color: primecolor,
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                              height: 25,
                              width: 25,
                              child: Image.asset('asset/images/watches.png')),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            'Watches',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.black54,
                              fontWeight: FontWeight.w500,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
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
