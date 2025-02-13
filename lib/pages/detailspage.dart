import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mca_project/pages/homepage.dart';
import '../components/mybutton.dart';

class ProductDetailPage extends StatefulWidget {
  void Function()? onTap;
   ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}



class _ProductDetailPageState extends State<ProductDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children:[ Stack(
          
          children:[ 
           Container(
          padding: EdgeInsets.only(left: 30,right: 30,top: 40,bottom: 20),
          width:MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: primecolor,borderRadius: BorderRadius.only(bottomRight: Radius.circular(140))),
          child: SizedBox(
            height: 300,
            width: 300,
            child: Image.asset('asset/images/shoe1.png'),
          
          ), ),
          Positioned(
              top: 60,
              left: 23,
            child: GestureDetector(
              onTap:(){} ,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                 
                child: Container(
                  decoration: BoxDecoration(color: Colors.white,),
                  child: IconButton(onPressed: (){}, icon: Icon(Icons.arrow_back_ios_new_rounded,)),
                ),
              ),
            ),
          ),]
        ),
        SizedBox(height: 35,),
        Padding(
          padding: EdgeInsets.only(left: 23,right: 23),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
           
            children: [
              Text('Air Jordan Series 6',style: GoogleFonts.inter(fontSize: 24,fontWeight: FontWeight.w600),),
              SizedBox(
                height: 16,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [Text('MRP',style: GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.w400),),
                SizedBox(width: 8,),
                  Text("\$ 7,000",style: GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.w800),),
                ],
              ),
              SizedBox(
                height: 16,
              ),
              Row(
             
                children:[
                  Text('No of items :',style: GoogleFonts.inter(fontSize: 16,fontWeight: FontWeight.bold)),
                   SizedBox(
                width: 8,
              ),
      
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 6,horizontal: 10),
                    width: 100,
                    decoration: BoxDecoration(border: Border.all(color: Colors.grey.shade600,width: 2),borderRadius: BorderRadius.circular(8),),
                    child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      
                      
                      children: [
                      Text('+',style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.bold,)),
                      Text('4',style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.bold,color: primecolor)),
                      Text('-',style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.bold,))
      
                      
                    ],),
                  )
                ]
              )
              ,
              SizedBox(
                height: 16,
              ),
              Text("About",style: GoogleFonts.inter(fontSize: 18,fontWeight: FontWeight.w600),),
              SizedBox(
                height: 8,
              ),
              SizedBox(child: Text("The upgraded S6 SiP runs up to 20 percent faster, allowing apps to also launch 20 percent faster, while maintaining the same all-day 18-hour battery life.",
              style: GoogleFonts.inter(fontSize: 16,),)),
              SizedBox(
                height: 35,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [

                   MyButton(color: Colors.white,onPressed: (){},buttonname:'Add to cart' ,icon: Icon(Icons.favorite),),
                   MyButton(color: primecolor,onPressed: (){},buttonname:'Add to cart' ,icon: Icon(Icons.shopping_bag,),),
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