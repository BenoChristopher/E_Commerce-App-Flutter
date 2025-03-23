// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// import '../components/mybutton.dart';

// class UiCard extends StatelessWidget {
//   const UiCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Row(
//         mainAxisAlignment:  MainAxisAlignment.start,
//         children: [
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
              
//               Container(
//              height: 120,
//               width: 130,
//                 decoration: BoxDecoration(
//                 color: Colors.grey.shade200,
//                   borderRadius: BorderRadius.circular(8),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.grey.shade300,
//                       blurRadius: 2,
//                       spreadRadius: 1,
//                       offset: Offset(1, 1,),
//                       blurStyle: BlurStyle.normal
                      
//                     )
//                   ]
//                 ),
//                 child: SizedBox(
//                   height: 150,
//                   width: 150,
//                   child: Image.asset("asset/images/shoe1.png"),),
//               ),
//               SizedBox(height: 12,),
                
              
                    
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: 12,vertical: 4),
                  
//                   decoration: BoxDecoration(
//                     border: Border.all(color: Colors.grey.shade400,width: 1),
//                     borderRadius: BorderRadius.circular(4)),
                  
                    
//                   child: Text("Qty:1",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
//                 )
                    
//             ],
//           ),
      
//           SizedBox(width: 20,),
      
//            Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
              
//               Text('Air Jordan',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
//           SizedBox(height: 10),
//           Text('\$200',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.grey[500]),),
//            SizedBox(height: 10),
//            Text('No of Products :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300,),),
//            SizedBox(height: 10),
//              Text('Total :',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,),),
//            SizedBox(height: 10),
//            MaterialButton(onPressed: (){},
//            color: Colors.red,
//            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             child: Row(
//           children: [
//             Icon(Icons.delete,color: Colors.white),
            
//             SizedBox(width: 5,)
            
//              ,Text("Delete",
//           style: GoogleFonts.inter
//             //blinker
//             (fontWeight: FontWeight.bold,color: Colors.white),
//           ),
//           ]
//         ),
//            )
//             ],
//           ),
//         ],
      
//       ),

//     );
//   }
// }